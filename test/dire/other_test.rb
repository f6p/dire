require 'test_helper'

class Dire::OtherTest < Minitest::Test
  def test_known
    refute other.known?
  end

  def test_type
    assert_equal 'other', other.type
  end

  def test_validate
    assert_raises Dire::Error::InvalidPath do
      Dire::Link.new files.path, root.path
    end
  end
end
