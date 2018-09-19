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

    public class Application : Gtk.Application {

        public GLib.List <MainWindow> windows;

        construct {
            application_id = Constants.PROJECT_NAME;
            flags |= ApplicationFlags.HANDLES_OPEN;

            //  schema = new Secret.Schema (Constants.PROJECT_NAME, Secret.SchemaFlags.NONE,
            //                           "id", Secret.SchemaAttributeType.INTEGER,
            //                           "schema", Secret.SchemaAttributeType.STRING);

            //  settings = new Sequeler.Services.Settings ();
            //  password_mngr = new Sequeler.Services.PasswordManager ();
            //  upgrade_mngr = new Sequeler.Services.UpgradeManager ();

            windows = new GLib.List <MainWindow> ();
        }

        public void new_window () {
            new RESTate.MainWindow (this).present ();
        }

        public override void window_added (Gtk.Window window) {
            windows.append (window as MainWindow);
            base.window_added (window);
        }

        public override void window_removed (Gtk.Window window) {
            windows.remove (window as MainWindow);
            base.window_removed (window);
        }

        protected override void activate () {
            var window = new MainWindow (this);
            this.add_window (window);
        }

        public static int main (string[] args) {

            var app = new RESTate.Application ();
            return app.run (args);
        }
    }
}