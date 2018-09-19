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

using Gtk;

namespace RESTate {

    public class RequestView : Gtk.Grid {
        public signal void submit_clicked ();

        private ComboBoxText httpMethodsComboBox;
        private Entry urlEntry;
        private Label statusLabel;
        private Label bodyLabel;
        private Box headerBox;
        private ScrolledWindow bodyTextWindow;
        private TextView bodyTextView;
        private Button submitButton;
        private RequestHeaderBox requestHeaderBox;

        public RequestHeaderBox request_header_box {
            get {
                return requestHeaderBox;
            }
        }

        public string status_text {
            get {
                return statusLabel.label;
            }

            set {
                statusLabel.label = value;
            }
        }

        public RequestView () {
            set_border_width (12);
            column_spacing = 6;
            row_spacing = 6;
            orientation = Gtk.Orientation.VERTICAL;

            httpMethodsComboBox = new ComboBoxText ();
            httpMethodsComboBox.append_text ("GET");
            httpMethodsComboBox.append_text ("POST");
            httpMethodsComboBox.append_text ("PUT");
            httpMethodsComboBox.append_text ("DELETE");
            httpMethodsComboBox.append_text ("HEAD");
            httpMethodsComboBox.append_text ("OPTIONS");
            httpMethodsComboBox.append_text ("PATCH");

            httpMethodsComboBox.active = 0;

            urlEntry = new Entry ();
            urlEntry.placeholder_text = "Enter URL e.g. http://www.example.com";
            //  urlEntry.width_request = 350;
            urlEntry.hexpand = true;

            statusLabel = new Label ("");
            statusLabel.set_line_wrap (true);

            submitButton = new Button.with_label ("Submit");
            submitButton.get_style_context ().add_class ("blue-color");
            submitButton.width_request = 70;

            bodyLabel = new Label ("<b>Body</b>");
            bodyLabel.set_use_markup (true);
            bodyLabel.set_line_wrap (true);
            bodyLabel.valign = Gtk.Align.START;

            bodyTextView = new TextView ();
            bodyTextView.set_wrap_mode (Gtk.WrapMode.WORD);
            bodyTextView.hexpand = false;
            bodyTextView.vexpand = true;

            bodyTextWindow = new ScrolledWindow (null, null);
            bodyTextWindow.hexpand = false;
            bodyTextWindow.vexpand = true;

            bodyTextWindow.height_request = 300;
            bodyTextWindow.add (bodyTextView);

            Box topBox = new Box (Gtk.Orientation.HORIZONTAL, 6);
            topBox.add (httpMethodsComboBox);
            topBox.add (urlEntry);
            topBox.add (submitButton);

            //header and body stack
            headerBox = new Box (Gtk.Orientation.VERTICAL, 6);
            requestHeaderBox = new RequestHeaderBox ();
            requestHeaderBox.btn_add.clicked.connect (add_header_clicked);
            headerBox.add (requestHeaderBox);

            Stack stack = new Stack ();
            stack.set_transition_type (Gtk.StackTransitionType.SLIDE_LEFT_RIGHT);
            stack.set_transition_duration (400);
            stack.add_titled (headerBox, "Headers", "Headers");
            stack.add_titled (bodyTextWindow, "Body", "Body");

            StackSwitcher switcher = new StackSwitcher ();
            switcher.stack = stack;

            Box bottomBox = new Box (Gtk.Orientation.VERTICAL, 0);
            bottomBox.pack_start (switcher, false, false, 3);
            bottomBox.pack_start (stack, true, true, 0);

            //Main Layout
            this.add (topBox);
            this.add (bottomBox);

            submitButton.clicked.connect ( () => {
                submit_clicked ();
            });
        }

        private void add_header_clicked () {
            if (requestHeaderBox.entry_key.get_text () == ""
                || requestHeaderBox.entry_value.get_text () == "") {
                //statusLabel.label = "Key Value pair must not be empty";
                return;
            }
            //  statusLabel.label = "";

            var lbl_k = new Entry ();
            lbl_k.set_text (requestHeaderBox.entry_key.get_text ());
            lbl_k.editable = false;
            lbl_k.hexpand = true;

            var lbl_v = new Entry ();
            lbl_v.set_text (requestHeaderBox.entry_value.get_text ());
            lbl_v.editable = false;
            lbl_v.hexpand = true;

            var del = new Button.with_label ("Remove");
            del.get_style_context ().add_class ("red-color");

            NameValuePair header = new NameValuePair ();
            header.name = lbl_k.get_text ();
            header.value = lbl_v.get_text ();

            requestHeaderBox.key_value_list.append (header);

            var row_box = new Box (Gtk.Orientation.HORIZONTAL, 6);
            row_box.add (lbl_k);
            row_box.add (lbl_v);
            row_box.add (del);

            headerBox.add (row_box);
            del.clicked.connect ( () => {
                requestHeaderBox.key_value_list.remove (header);

                stdout.printf ("Delete, number of headers: %u\n", requestHeaderBox.key_value_list.length ());
                headerBox.remove (row_box);
            });

            requestHeaderBox.entry_key.set_text ("");
            requestHeaderBox.entry_value.set_text ("");
            show_all ();
            stdout.printf ("Add, number of headers: %u\n", requestHeaderBox.key_value_list.length ());
        }

        public string get_http_method () {
            return httpMethodsComboBox.get_active_text ();
        }

        public string get_url_text () {
            return urlEntry.get_text ();
        }



        public string get_body_text () {
            return bodyTextView.buffer.text;
        }
    }
}