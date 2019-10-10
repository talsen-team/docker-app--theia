
project( 'talsen-kata',
         'cpp',
         default_options : [ 'c_std=c11', 'cpp_std=c++17' ] )

cpp_compiler = meson.get_compiler('cpp')

gunit_lib_dir = get_option( 'gunit_lib_dir' )
gunit_include_dir = get_option( 'gunit_include_dir' )

deps = [
    dependency( 'threads' ),
    cpp_compiler.find_library( 'gunit', dirs : gunit_lib_dir ),
]

includes = include_directories( 'src',
                                gunit_include_dir )

sources = [
    'src/main.cpp',
]

exe = executable( 'run-workspace',
                  sources,
                  dependencies :  deps,
                  include_directories : includes )

test( 'run workspace', exe )
