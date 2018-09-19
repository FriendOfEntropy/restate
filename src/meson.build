conf_data = configuration_data()
conf_data.set('PROJECT_NAME', meson.project_name())
conf_data.set('EXEC_NAME', meson.project_name())
conf_data.set('DATADIR', get_option('datadir'))
conf_data.set('PKGDATADIR', get_option('datadir') + '/' + meson.project_name())
conf_data.set('GETTEXT_PACKAGE', meson.project_name())
conf_data.set('RELEASE_NAME', 'RESTate')
conf_data.set('VERSION', '0.1.0')
conf_data.set('VERSION_INFO', 'Native REST UI Client')
conf_data.set('PREFIX', get_option('prefix'))

config_header = configure_file(
    input: 'config.vala.in',
    output: 'config.vala',
    configuration: conf_data
)

glib_dep = dependency('glib-2.0', version: '>=2.30.0')
gio_dep = dependency('gio-2.0', version: '>=2.26')
gee_dep = dependency('gee-0.8', version: '>=0.8')
gtk_dep = dependency('gtk+-3.0', version: '>=3.6.0')
json_dep = dependency ('json-glib-1.0', version: '>=1.0')
libsoup_dep = dependency ('libsoup-2.4', version: '>=2.4')


dependencies = [
    glib_dep,
    gio_dep,
    gee_dep,
    gtk_dep,
    json_dep,
    libsoup_dep
]


code_files = files(
    'Application.vala',
    'MainWindow.vala',
    'RequestView.vala',
    'ResponseView.vala',
    'NameValuePair.vala',
    'RequestHeaderBox.vala',
    'Stylesheet.vala'
)


