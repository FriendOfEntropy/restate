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

        public signal void add_clicked (string name, string value);

        private Button addButton { get; set; }
        private Entry nameEntry;
        private Entry valueEntry;
        private List<NameValuePair> nameValuePairList;

        public RequestHeaderBox () {
            spacing = 6;
            orientation = Gtk.Orientation.HORIZONTAL;

            nameValuePairList = new List<NameValuePair> ();

            nameEntry = new Entry ();
            nameEntry.hexpand = true;
            nameEntry.placeholder_text = "Name";

            valueEntry = new Entry ();
            valueEntry.hexpand = true;
            valueEntry.placeholder_text = "Value";

            addButton = new Button.with_label ("Add");
            addButton.width_request = 70;
            addButton.expand = false;
            addButton.get_style_context ().add_class (Gtk.STYLE_CLASS_SUGGESTED_ACTION);

            this.add (nameEntry);
            this.add (valueEntry);
            this.add (addButton);

            addButton.clicked.connect ( () => {
                add_clicked (nameEntry.text, valueEntry.text);
            });
        }

        public List<NameValuePair> name_value_pairs {
            get {
                return nameValuePairList;
            }

            set {
                nameValuePairList = value.copy ();
            }
        }

        public void clear_entries () {
            nameEntry.text = "";
            valueEntry.text = "";
        }
    }
}