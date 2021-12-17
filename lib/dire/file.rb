require 'mimemagic'

module Dire
  class File < Node
    def binary?
      return @binary if @binary

      if mime && !['application', 'text'].include?(mime.mediatype)
        return @binary = true
      end

      @binary = !absolute_path.read.valid_encoding? rescue true
    end

    def mime
      @mime ||= MimeMagic.by_magic absolute_path.open
    end

    def text?
      !binary?
    end

    def validate!
      super && validate_type!('file')
    end
  end
end
