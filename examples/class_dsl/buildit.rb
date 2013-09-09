class Package
    attr_reader :include_dirs, :executables

    class << self
        def include_dirs(val=nil)
            if @include_dirs.nil?
                @include_dirs = []
            end
            if val.nil?
                @include_dirs
            else
                if val.kind_of? Array
                    @include_dirs.concat val
                else
                    @include_dirs << val
                end
            end
            # val.nil? ? @include_dirs : @include_dirs << val
        end

        def executable(name, files)
            if @executables.nil?
                @executables = {}
            end
            @executables[name] = files
        end

        def to_s
            msg = ["Package '#{self.name.downcase}':"]
            if @include_dirs.nil?
                msg << "  No include directories"
            else
                msg << "  include directories:"
                @include_dirs.each do |include_dir|
                    msg << "    '#{include_dir}'"
                end
            end
            if @executables.nil?
                msg << "  No executables"
            else
                msg << "  executables:"
                @executables.each do |name, files|
                    msg << "    '#{name}':"
                    files.each do |file|
                        msg << "      '#{file}'"
                    end
                end
            end
            msg.join("\n")
        end
    end
end
