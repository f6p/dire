module Dire
  class Link < Node
    def broken?
      !link.exist? || !inside?(link)
    end

    def param
      chop(link).to_s
    end

    def validate!
      super && validate_type!('link')

      if broken?
        raise Dire::Error::InvalidLink, 'Dead link'
      end

      true
    end

    private

    def link
      path.readlink.expand_path path.dirname
    end
  end
end
