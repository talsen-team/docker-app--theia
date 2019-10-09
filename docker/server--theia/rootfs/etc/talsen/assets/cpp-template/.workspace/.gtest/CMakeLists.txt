cmake_minimum_required( VERSION 2.6 )

# Find all C++ files
file( GLOB sources "*.cpp" )

add_executable( run-tests ${sources} )
