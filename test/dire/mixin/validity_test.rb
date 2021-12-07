require 'test_helper'

class Dire::Mixin::ValidityTest < Minitest::Test
  def test_validate
    assert files.validate!

    assert_raises(Dire::Error::InvalidPath) { other.validate! }
  end
end
