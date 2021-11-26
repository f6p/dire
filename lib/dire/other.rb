module Dire
  class Other < Node
    def known?
      false
    end

    def type
      'other'
    end

    def validate!
      super && validate_type!('other')
    end
  end
end
