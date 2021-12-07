require 'test_helper'

class Dire::Module::ValidityTest < Minitest::Test
  def test_validate
    assert files.validate!

    assert_raises(Dire::Error::InvalidPath) { other.validate! }
  end
end
