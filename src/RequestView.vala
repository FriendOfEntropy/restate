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
        private ScrolledWindow previewWindow;
        private TextView previewTextView;
        private Button submitButton;
        private RequestHeaderBox requestHeaderBox;

        private List<NameValuePair> nameValuePairList;

        private string BODY = "Body";
        private string HEADERS = "Headers";
        private string PREVIEW = "Preview";


        public List<NameValuePair> headers {
            owned get {
                List<NameValuePair> headers_copy = new List<NameValuePair>();
                headers_copy = nameValuePairList.copy ();
                return headers_copy;
            }
        }

        //  public RequestHeaderBox request_header_box {
        //      get {
        //          return requestHeaderBox;
        //      }
        //  }

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
            submitButton.get_style_context ().add_class (Gtk.STYLE_CLASS_SUGGESTED_ACTION);
            submitButton.width_request = 70;

            bodyLabel = new Label ("<b>Body</b>");
            bodyLabel.set_use_markup (true);
            bodyLabel.set_line_wrap (true);
            bodyLabel.valign = Gtk.Align.START;

            bodyTextView = new TextView ();
            bodyTextView.wrap_mode = Gtk.WrapMode.WORD;
            bodyTextView.hexpand = false;
            bodyTextView.vexpand = true;

            bodyTextWindow = new ScrolledWindow (null, null);
            bodyTextWindow.hexpand = false;
            bodyTextWindow.vexpand = true;
            bodyTextWindow.height_request = 300;
            bodyTextWindow.add (bodyTextView);

            previewTextView = new TextView ();
            previewTextView.wrap_mode = Gtk.WrapMode.WORD;
            previewTextView.hexpand = false;
            previewTextView.vexpand = true;
            previewTextView.editable = false;

            previewWindow = new ScrolledWindow (null, null);
            previewWindow.hexpand = false;
            previewWindow.vexpand = true;
            previewWindow.height_request = 300;
            previewWindow.add (previewTextView);

            Box topBox = new Box (Gtk.Orientation.HORIZONTAL, 6);
            topBox.add (httpMethodsComboBox);
            topBox.add (urlEntry);
            topBox.add (submitButton);

            nameValuePairList = new List<NameValuePair> ();
            headerBox = new Box (Gtk.Orientation.VERTICAL, 6);
            requestHeaderBox = new RequestHeaderBox ();
            requestHeaderBox.add_clicked.connect (add_header_clicked);
            headerBox.add (requestHeaderBox);

            Stack stack = new Stack ();
            stack.set_transition_type (Gtk.StackTransitionType.SLIDE_LEFT_RIGHT);
            stack.set_transition_duration (400);
            stack.add_titled (bodyTextWindow, BODY, BODY);
            stack.add_titled (headerBox, HEADERS, HEADERS);
            stack.add_titled (previewWindow, PREVIEW, PREVIEW);

            Gtk.Grid tabHeader = new Gtk.Grid ();

            Granite.Widgets.ModeButton tabs = new Granite.Widgets.ModeButton ();
            tabs.append (new TabHeaderButton ("accessories-text-editor", BODY, _(BODY)));
            tabs.append (new TabHeaderButton ("x-office-spreadsheet", HEADERS, _(HEADERS)));
            tabs.append (new TabHeaderButton ("x-office-document", PREVIEW, _(PREVIEW)));
            tabs.set_active (0);
            tabs.margin = 10;
            tabs.margin_bottom = 9;

            tabHeader.attach (tabs, 0, 0, 1, 1);

            tabs.mode_changed.connect ((tab) => {

                if (tab.name == BODY) {
                }

                if (tab.name == HEADERS) {
                }

                if (tab.name == PREVIEW) {
                    //string method = requestView.get_http_method ();
                    //string url = requestView.get_url_text ();

                    if ((urlEntry.text != null) && (urlEntry.text != "")) {

                        //  Soup.Message message = new Soup.Message (httpMethodsComboBox.get_active_text (), urlEntry.text);
                        //  message.request_body.append_take (bodyTextView.buffer.text.data);

                        //  StringBuilder sb = new StringBuilder ();
                        //  sb.append ("%s: %s\n".printf (message.method, message.uri.get_path ()));

                        //  foreach (NameValuePair header in nameValuePairList) {
                        //      message.request_headers.append (header.name, header.value);
                        //  }

                        //  message.request_headers.foreach ((name, val) => {
                        //      sb.append ("%s: %s\n".printf (name, val));
                        //  });

                        //  sb.append ((string) message.response_body.flatten ().data);






                        try {
                            StringBuilder sb = new StringBuilder ();

                            Soup.Session session = new Soup.Session ();
                            Soup.Message message = new Soup.Message (httpMethodsComboBox.get_active_text (), urlEntry.text);
                            message.request_body.append_take (bodyTextView.buffer.text.data);
                            foreach (NameValuePair header in nameValuePairList) {
                                message.request_headers.append (header.name, header.value);
                            }

                            InputStream stream = session.send (message);
                            DataInputStream data_stream = new DataInputStream (stream);


                            string? line;
                            while ((line = data_stream.read_line ()) != null) {
                                sb.append ("%s\n".printf (line));
                            }

                            previewTextView.buffer.text = sb.str;

                        }
                        catch (Error e) {
                            stderr.printf ("Error: %s\n", e.message);
                        }
                    }
                }

                stack.set_visible_child_name (tab.name);
            });


            //  StackSwitcher switcher = new StackSwitcher ();
            //  switcher.stack = stack;

            Box bottomBox = new Box (Gtk.Orientation.VERTICAL, 0);
            bottomBox.pack_start (tabHeader, false, false, 3);
            bottomBox.pack_start (stack, true, true, 0);

            //Main Layout
            this.add (topBox);
            this.add (bottomBox);

            submitButton.clicked.connect ( () => {
                submit_clicked ();
            });
        }

        private void add_header_clicked (string name, string value) {
            if (name == "" || value == "") {
                return;
            }

            var nameLabel = new Entry ();
            nameLabel.set_text (name);
            nameLabel.editable = false;
            nameLabel.hexpand = true;

            var valueLabel = new Entry ();
            valueLabel.set_text (value);
            valueLabel.editable = false;
            valueLabel.hexpand = true;

            Button removeButton = new Button.with_label ("Remove");
            removeButton.get_style_context ().add_class (Gtk.STYLE_CLASS_DESTRUCTIVE_ACTION);

            NameValuePair header = new NameValuePair ();
            header.name = nameLabel.get_text ();
            header.value = valueLabel.get_text ();

            nameValuePairList.append (header);

            Box rowBox = new Box (Gtk.Orientation.HORIZONTAL, 6);
            rowBox.add (nameLabel);
            rowBox.add (valueLabel);
            rowBox.add (removeButton);

            headerBox.add (rowBox);

            removeButton.clicked.connect ( () => {
                nameValuePairList.remove (header);
                headerBox.remove (rowBox);
            });

            requestHeaderBox.clear_entries ();
            show_all ();
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