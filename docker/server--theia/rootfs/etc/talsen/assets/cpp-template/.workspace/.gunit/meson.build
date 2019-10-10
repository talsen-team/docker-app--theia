
project( 'talsen-kata',
         'cpp'
        default_options : [ 'c_std=c11', 'cpp_std=c++17' ] )

deps = [
    dependency( 'threads' )
]

includes = include_directories( 'src',
                                '.workspace/.gunit/lib/include' )

sources = [
    'src/main.cpp',
]

executable( 'run-workspace',
            sources,
            dependencies :  deps,
            include_directories : includes )
