require 'buildit'

package :simple

include_dirs 'include', 'vendor/include'
include_dirs '/usr/local/include/pkg-1.1'

executable :foo, 'src/foo.cpp', 'src/foo2.cpp', options=[:no_auto_linking]

# link_libraries :foo, dependencies.link_libraries.exclude('roscpp', 'tinyxml', 'boost_system', 'boost_thread')
# link_libraries :foo, dependencies[:roscpp].link_libraries.only('roscpp')
# link_libraries :foo, dependencies[:roscpp].dependencies[:tinyxml].link_libraries
link_libraries :foo, ['boost_system', 'boost_thread']

executable :bar, 'src/bar.cpp', 'src/bar2.cpp', 'src/bar3.cpp'

summarize
