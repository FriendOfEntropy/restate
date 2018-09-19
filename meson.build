project('com.github.friendofentropy.restate', 'vala', 'c', version: '0.1.0')

gnome = import('gnome')

add_project_arguments(
    ['--vapidir', join_paths(meson.current_source_dir(), 'vapi')],
    language: 'vala'
)

code_resources = gnome.compile_resources(
    'code-resources', 'data/' + meson.project_name() + '.gresource.xml',
    source_dir: 'data',
)

add_global_arguments ('-DGETTEXT_PACKAGE="' + meson.project_name () + '"', language:'c')

vala_lint = find_program('io.elementary.vala-lint', required : false)
if vala_lint.found()
    test (
        'Vala lint',
        vala_lint,
        args: ['-d', join_paths(meson.source_root(), 'src')]
    )
endif

subdir('src')
subdir('data')

executable(
    meson.project_name(),
    code_resources,
    config_header,
    code_files,
    dependencies: dependencies,
    install: true
)


meson.add_install_script('meson/post_install.py')