require 'buildit'

class Simple < Package
    include_dirs ['include', 'vendor/include']
    include_dirs '/usr/local/include/pkg-1.1'

    executable :foo, ['src/foo.cpp', 'src/bar.cpp']
end

puts Simple
