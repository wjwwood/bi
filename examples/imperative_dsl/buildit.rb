class Package
    attr_reader :include_dirs

    def initialize
        @include_dirs = []
    end

    class << self
        def include_dirs(val=nil)
            if @include_dirs.nil?
                @include_dirs = []
            end
            val.nil? ? @include_dirs : @include_dirs << val
        end
    end
end
