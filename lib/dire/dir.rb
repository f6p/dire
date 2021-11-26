module Dire
  class Dir < Node
    @@invalid_link_handler = -> (path) {}

    def self.invalid_link_handler= lambda
      @@invalid_link_handler = lambda
    end

    @@invalid_path_handler = -> (path) {}

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
      @nodes = @nodes.filter_map do |node|
        next if ignore? node

        if absolute_path.to_s < node.to_s
          begin
            get node
          rescue Dire::Error::InvalidLink
            @@invalid_link_handler.(node)
          rescue Dire::Error::InvalidPath
            @@invalid_path_handler.(node)
          end
        end
      end
    end
  end
end
