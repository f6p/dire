require 'test_helper'

class Dire::Mixin::PathTest < Minitest::Test
  def test_absolute_path
    assert node.absolute_path.absolute?

    assert_equal root.absolute_path.join('node'), node.absolute_path
  end

  def test_param
    assert_equal node.relative_path.to_s, node.param
  end

  def test_relative_path
    assert node.relative_path.relative?

    assert_equal Pathname.new('node'), node.relative_path
  end
end
