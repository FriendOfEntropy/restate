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
        private Label lbl_res_code_title;
        private Label lbl_res_code;
        private Label lbl_res_body_title;
        private Label lbl_res_body;

        public ResponseView () {
            set_border_width (12);
            column_spacing = 6;
            row_spacing = 6;

            bodyLabelWindow = new ScrolledWindow (null, null);
            bodyLabelWindow.height_request = 250;
            bodyLabelWindow.vexpand = true;
            bodyLabelWindow.hexpand = true;

            lbl_res_code = new Label ("");
            lbl_res_code.set_line_wrap (true);

            lbl_res_code_title = new Label ("<b>Response Code</b>");
            lbl_res_code_title.set_use_markup (true);
            lbl_res_code_title.set_line_wrap (true);

            lbl_res_body = new Label ("");
            lbl_res_body.set_line_wrap (true);
            lbl_res_body.set_selectable (true);
            lbl_res_body.valign = Gtk.Align.START;
            lbl_res_body.halign = Gtk.Align.START;

            lbl_res_body_title = new Label ("<b>Response Body</b>");
            lbl_res_body_title.set_use_markup (true);
            lbl_res_body_title.set_line_wrap (true);

            bodyLabelWindow.add (lbl_res_body);

            attach (lbl_res_code_title, 0, 0, 1, 1);
            attach (lbl_res_code, 0, 1, 1, 1);
            attach (lbl_res_body_title, 0, 2, 1, 1);
            attach (bodyLabelWindow, 0, 3, 1, 1);
        }

        public void set_response_body_text (string body_text) {
            lbl_res_body.label = body_text;
        }

        public void set_response_code_text (string res_code_text) {
            lbl_res_code.label = res_code_text;
        }
    }
}