require 'test_helper'

class Dire::DirTest < Minitest::Test
  def test_dirs
    assert_items 2, root.dirs
    assert_items 1, links.dirs
  end

  def test_files
    assert_items 1, root.files
    assert_items 1, links.files

    assert_invalid_link_handler { links.files }
  end

  def test_list
    assert_items 3, root.list
    assert_items 2, links.list

    assert_invalid_link_handler { links.list }
  end

  def test_root
    assert root.root?
    refute links.root?
  end

  def test_validate
    assert files

    assert_raises Dire::Error::InvalidPath do
      Dire::Dir.new files.get('dune.zip').path, root.path
    end
  end

  private

  def assert_items size, list
    assert_equal size, list.send(:size)
  end

  def assert_invalid_link_handler &block
    msg = '.'

    Dire::Dir.invalid_link_handler = -> (_, _, _) { print msg }

    assert_output(msg) { block.call }
  end
end
