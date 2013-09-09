require 'singleton'

class ContextSingleton
    include Singleton
    attr_accessor :current_package, :package_dict

    def initialize
        @current_package = nil
        @package_dict = {}
    end
end

def package(name)
    c = ContextSingleton.instance
    c.current_package = name
    c.package_dict[name] = {}
end

def include_dirs(val)
    c = ContextSingleton.instance
    if not c.package_dict[c.current_package].has_key? 'include_dirs'
        c.package_dict[c.current_package]['include_dirs'] = []
    end
    if val.kind_of? Array
        c.package_dict[c.current_package]['include_dirs'].concat val
    else
        c.package_dict[c.current_package]['include_dirs'] << val
    end
end

def executable(name, files)
    c = ContextSingleton.instance
    if not c.package_dict[c.current_package].has_key? 'executables'
        c.package_dict[c.current_package]['executables'] = {}
    end
    c.package_dict[c.current_package]['executables'][name] = files
end

def summarize
    c = ContextSingleton.instance
    msg = ["Packages:"]
    c.package_dict.each do |pkg_name, pkg_dict|
        msg << "  '#{pkg_name}':"
        if not pkg_dict.has_key? 'include_dirs'
            msg << "    No include directories."
        else
            msg << "    Include directories:"
            pkg_dict['include_dirs'].each do |inc_dir|
                msg << "      '#{inc_dir}'"
            end
        end
        if not pkg_dict.has_key? 'executables'
            msg << "    No executables."
        else
            msg << "    Executables:"
            pkg_dict['executables'].each do |name, files|
                msg << "      '#{name}':"
                files.each do |file|
                    msg << "        '#{file}'"
                end
            end
        end
    end
    puts msg.join("\n")
end
