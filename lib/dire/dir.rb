module Dire
  class Dir < Node
    @@invalid_link_handler = -> (root, nodes, path) {}

    def self.invalid_link_handler= lambda
      @@invalid_link_handler = lambda
    end

    @@invalid_path_handler = -> (root, nodes, path) {}

    def self.invalid_path_handler= lambda
      @@invalid_path_handler = lambda
    end

    def dirs
      nodes.select { |i| i.absolute_path.directory? }
    end

    def files
      nodes.select { |i| not i.absolute_path.directory? }
    end

    def list
      dirs + files
    end

    def root?
      not parent
    end

    def validate!
      super && validate_type!('directory')
    end

    private

    def nodes
      return @nodes if @nodes

      @nodes = absolute_path.glob '*', ::File::FNM_DOTMATCH
      @nodes = @nodes.each_with_object(Array.new) do |path, nodes|
        next if ignore? path

        if absolute_path.to_s < path.to_s
          begin
            nodes.push get(path)
          rescue Dire::Error::InvalidLink
            @@invalid_link_handler.(root, nodes, path)
          rescue Dire::Error::InvalidPath
            @@invalid_path_handler.(root, nodes, path)
          end
        end
      end
    end
  end
end
