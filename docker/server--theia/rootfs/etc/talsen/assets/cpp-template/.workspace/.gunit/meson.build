
project( 'talsen-kata',
         'cpp',
         default_options : [ 'c_std=c11', 'cpp_std=c++17' ] )

cpp_compiler = meson.get_compiler('cpp')

opt_exe_name = get_option( 'exe_name' )
opt_gunit_lib_dir = get_option( 'gunit_lib_dir' )
opt_gunit_include_dir = get_option( 'gunit_include_dir' )

deps = [
    dependency( 'threads' ),
    cpp_compiler.find_library( 'gunit', dirs : opt_gunit_lib_dir ),
]

includes = include_directories( 'src',
                                opt_gunit_include_dir )

sources = [
    'src/main.cpp',
]

executable( opt_exe_name,
            sources,
            dependencies :  deps,
            include_directories : includes )
