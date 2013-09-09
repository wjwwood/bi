require 'buildit'

class Simple < Package
    include_dirs ['include1', 'include2']
    include_dirs 'include3'
end

puts Simple.include_dirs
