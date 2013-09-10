require 'singleton'

class ContextSingleton
    include Singleton
    attr_accessor :current_package, :package_dict

    def initialize
        @current_package = nil
        @package_dict = {}
    end
end

class Executable
    attr_reader :name, :files

    def initialize name, *args
        @name = name
        @files = []
        for arg in args
            if arg.kind_of? Array
                @files.concat arg
            else
                @files << arg
            end
        end
        @link_libraries = []
    end

    def link_libraries *args
        return @link_libraries if args.empty?
        for arg in args
            if arg.kind_of? Array
                @link_libraries.concat arg
            else
                @link_libraries << arg
            end
        end
    end
end

def package name
    c = ContextSingleton.instance
    c.current_package = name
    c.package_dict[name] = {}
end

def include_dirs *args
    c = ContextSingleton.instance
    unless c.package_dict[c.current_package].has_key? :include_dirs
        c.package_dict[c.current_package][:include_dirs] = []
    end
    for val in args
        if val.kind_of? Array
            c.package_dict[c.current_package][:include_dirs].concat val
        else
            c.package_dict[c.current_package][:include_dirs] << val
        end
    end
end

def executable name, *args
    c = ContextSingleton.instance
    unless c.package_dict[c.current_package].has_key? :executables
        c.package_dict[c.current_package][:executables] = {}
    end
    puts args
    unless args.empty?
        if not c.package_dict[c.current_package][:executables].has_key? name
            c.package_dict[c.current_package][:executables][name] = Executable.new name, *args
        else
            raise "Executabe #{name} already exists"
        end
    end
    unless c.package_dict[c.current_package][:executables].has_key? name
        raise "No #{name} executable exists"
    end
    return c.package_dict[c.current_package][:executables][name]
end

def link_libraries name, *args
    c = ContextSingleton.instance
    if not c.package_dict[c.current_package][:executables].has_key? name
        raise "No such executable #{name}."
    end
    c.package_dict[c.current_package][:executables][name].link_libraries args
end

def summarize
    c = ContextSingleton.instance
    msg = ["Packages:"]
    c.package_dict.each do |pkg_name, pkg_dict|
        msg << "  '#{pkg_name}':"
        if not pkg_dict.has_key? :include_dirs
            msg << "    No include directories."
        else
            msg << "    include directories:"
            pkg_dict[:include_dirs].each do |inc_dir|
                msg << "      '#{inc_dir}'"
            end
        end
        if not pkg_dict.has_key? :executables
            msg << "    No executables."
        else
            msg << "    executables:"
            pkg_dict[:executables].each do |name, exec|
                msg << "      '#{name}':"
                msg << "        files:"
                exec.files.each do |file|
                    msg << "          '#{file}'"
                end
                msg << "        link libraries:"
                exec.link_libraries.each do |lib|
                    msg << "          '#{lib}'"
                end
            end
        end
    end
    puts msg.join("\n")
end
