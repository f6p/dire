require 'test_helper'

class Dire::Module::CheckTest < Minitest::Test
  def test_equal
    assert_equal node, node.dup

    refute_equal node, other
  end

  def test_broken
    refute node.broken?
  end

  def test_known?
    assert node.known?
  end

  def test_parent
    assert node.parent? root

    refute node('dir/node').parent? root
  end

  def test_root
    refute node.root?
  end
end
