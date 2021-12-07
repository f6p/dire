module Dire
  class Node
    include Mixin::Check, Mixin::Path, Mixin::Validity

    attr_reader :path, :root

    def initialize node, root, validate = true
      @path = str2abs node
      @root = plant root

      validate! if validate
    end

    def get path, validate = true
      path = expand path
      type = path.ftype rescue nil

      const = case type
        when 'directory' then Dir
        when 'file'      then File
        when 'link'      then Link

        else Other
      end

      const.new path, root, validate
    end

    def parent
      Dire::Dir.new absolute_path.join('..'), root
    rescue Dire::Error::InvalidPath
      nil
    end

    def to_s
      relative_path.to_s
    end

    def type
      path.ftype rescue 'other'
    end

    private

    def plant root
      root = str2abs root

      unless root.directory?
        raise Dire::Error::InvalidRoot, 'Not a dir'
      end

      root
    end

    def str2abs path
      Pathname.new(path).expand_path
    end
  end
end
