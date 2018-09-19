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

    public class RequestHeaderBox : Box {

        public Button btn_add { get; set; }
        public Entry entry_key { get; set; }
        public Entry entry_value { get; set; }
        public List<NameValuePair> key_value_list;

        public RequestHeaderBox () {
            spacing = 6;
            orientation = Gtk.Orientation.HORIZONTAL;

            key_value_list = new List<NameValuePair> ();

            entry_key = new Entry ();
            entry_key.hexpand = true;
            entry_key.placeholder_text = "Key";

            entry_value = new Entry ();
            entry_value.hexpand = true;
            entry_value.placeholder_text = "Value";

            btn_add = new Button.with_label ("Add");
            btn_add.width_request = 70;
            btn_add.expand = false;
            btn_add.get_style_context ().add_class ("blue-color");

            this.add (entry_key);
            this.add (entry_value);
            this.add (btn_add);
        }
    }
}