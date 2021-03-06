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

            string REQ = "Request";
            string RESP = "Response";

            this.title = "RESTate";
            this.window_position = Gtk.WindowPosition.CENTER;
            this.set_default_size (800,400);
            this.destroy.connect (Gtk.main_quit);

            Gtk.Stack stack = new Gtk.Stack ();
            stack.set_transition_type (Gtk.StackTransitionType.SLIDE_LEFT_RIGHT);
            stack.set_transition_duration (400);

            RequestView requestView = new RequestView ();
            ResponseView responseView = new ResponseView ();

            requestView.submit_clicked.connect ( (message) => {

                Soup.Session session = new Soup.Session ();

                requestView.status_text = "Waiting For Response";

                session.queue_message (message, (sess, mess) => {
                    requestView.status_text = "";
                    responseView.response_code = "%u: %s".printf (mess.status_code, Soup.Status.get_phrase (mess.status_code));
                    responseView.response_body = (string) mess.response_body.flatten ().data;
                    stack.set_visible_child_name (RESP);
                });
            });

            stack.add_titled (requestView, REQ, REQ);
            stack.add_titled (responseView, RESP, RESP);

            Gtk.StackSwitcher sw = new Gtk.StackSwitcher ();
            sw.stack = stack;
            sw.halign = Gtk.Align.CENTER;
            sw.vexpand = false;


            Gtk.Box vbox = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
            vbox.pack_start (sw, false, false, 12);
            vbox.pack_start (stack, true, true,0);
            this.add (vbox);


            Gtk.CssProvider css_provider = new Gtk.CssProvider ();
            css_provider.load_from_resource ("/com/github/friendofentropy/restate/Application.css");

            Gtk.StyleContext.add_provider_for_screen (
                Gdk.Screen.get_default (), css_provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
            );

            show_all ();
            show ();
            present ();
        }
    }
}