/*
* Copyright (c) 2018 FriendOfEntropy (https://github.com/FriendOfEntropy/restate)
*
* This program is free software; you can redistribute it and/or
* modify it under the terms of the GNU General Public
* License as published by the Free Software Foundation; either
* version 3 of the License, or (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* General Public License for more details.
*
* You should have received a copy of the GNU General Public
* License along with this program; if not, write to the
* Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
* Boston, MA 02110-1301 USA
*
* Authored by: FriendOfEntropy <friendofentropy@gmail.com>
*/

namespace RESTate {

    public class MainWindow : Gtk.ApplicationWindow {
        public weak RESTate.Application app { get; construct; }

        public MainWindow (RESTate.Application restate_app) {
            Object (
                application: restate_app,
                app: restate_app,
                icon_name: "com.github.friendofentropy.restate"
            );
        }

        construct {

            //set window params
            this.title = "RESTate";
            this.window_position = Gtk.WindowPosition.CENTER;
            this.set_default_size (800,400);
            this.destroy.connect (Gtk.main_quit);

            //create stack for request and response
            var stack = new Gtk.Stack ();
            stack.set_transition_type (Gtk.StackTransitionType.SLIDE_LEFT_RIGHT);
            stack.set_transition_duration (400);

            string REQUEST_TITLE = "Request";
            string RESPONSE_TITLE = "Response";

            var requestView = new RequestView ();
            var responseView = new ResponseView ();

            //set submit callback function
            requestView.submit_clicked.connect ( () => {

                string method = requestView.get_http_method ();
                string url = requestView.get_url_text ();
                var session = new Soup.Session ();
                var message = new Soup.Message (method, url);


                if (message.get_uri () == null) {
                    requestView.status_text = "Invalid URL";
                    return;
                }

                requestView.status_text = "Waiting For Response";

                foreach (var header in requestView.request_header_box.key_value_list) {
                    message.request_headers.append (header.name, header.value);
                }

                string str_body = requestView.get_body_text ();
                message.request_body.append_take (str_body.data);

                session.queue_message (message, (sess, mess) => {
                    requestView.status_text = "";
                    responseView.set_response_code_text ("%u".printf (mess.status_code));
                    responseView.set_response_body_text ( (string) mess.response_body.flatten ().data);
                    stack.set_visible_child_name (RESPONSE_TITLE);
                });
            });

            stack.add_titled (requestView, REQUEST_TITLE, REQUEST_TITLE);
            stack.add_titled (responseView, RESPONSE_TITLE, RESPONSE_TITLE);

            //create the stack switcher
            var sw = new Gtk.StackSwitcher ();
            sw.stack = stack;
            sw.halign = Gtk.Align.CENTER;
            sw.vexpand = false;

            //put the stack and stack switcher to box
            //then add the box to window
            var vbox = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
            vbox.pack_start (sw, false, false, 12);
            vbox.pack_start (stack, true, true,0);
            this.add (vbox);

            show_all ();
            show ();
            present ();
        }
    }
}