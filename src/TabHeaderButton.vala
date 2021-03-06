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
    public class TabHeaderButton : Grid {
        public TabHeaderButton (string icon_name, string tooltip, string label) {
            name = tooltip;
            halign = Align.CENTER;

            Image icon;
            Label title = new Label (label);

            if (icon_name.contains ("/")) {
                icon = new Image.from_resource (icon_name);
            } else {
                icon = new Image.from_icon_name (icon_name, IconSize.BUTTON);
            }

            icon.margin = 3;

            attach (icon, 0, 0, 1, 1);
            attach (title, 1, 0, 1, 1);
        }
    }
}