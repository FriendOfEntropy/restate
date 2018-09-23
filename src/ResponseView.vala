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

    public class ResponseView : Gtk.Grid {

        private ScrolledWindow bodyLabelWindow;
        private Label responseCodeLabel;
        private Label responseCodeValueLabel;
        private Label responseBodyLabel;
        private TextView bodyTextView;

        public ResponseView () {
            set_border_width (12);
            column_spacing = 6;
            row_spacing = 6;

            bodyLabelWindow = new ScrolledWindow (null, null);
            bodyLabelWindow.height_request = 250;
            bodyLabelWindow.vexpand = true;
            bodyLabelWindow.hexpand = true;

            responseCodeLabel = new Label ("<b>Code</b>");
            responseCodeLabel.set_use_markup (true);
            responseCodeLabel.set_line_wrap (true);
            responseCodeLabel.halign = Align.END;

            responseCodeValueLabel = new Label ("");
            responseCodeValueLabel.set_line_wrap (true);
            responseCodeValueLabel.halign = Align.START;

            bodyTextView = new TextView ();
            bodyTextView.set_wrap_mode (Gtk.WrapMode.WORD);
            bodyTextView.hexpand = false;
            bodyTextView.vexpand = true;
            bodyTextView.editable = false;

            responseBodyLabel = new Label ("<b>Body</b>");
            responseBodyLabel.set_use_markup (true);
            responseBodyLabel.set_line_wrap (true);
            responseBodyLabel.halign = Align.START;

            bodyLabelWindow.add (bodyTextView);

            attach (responseCodeLabel, 0, 0, 1, 1);
            attach (responseCodeValueLabel, 1, 0, 1, 1);
            attach (responseBodyLabel, 0, 1, 1, 1);
            attach (bodyLabelWindow, 0, 2, 2, 1);
        }

        public string response_code {
            get {
                return responseCodeValueLabel.label;
            }

            set {
                responseCodeValueLabel.label = value;
            }
        }

        public string response_body {
            owned get {
                return bodyTextView.buffer.text;
            }

            set {
                bodyTextView.buffer.text = value;
            }
        }
    }
}