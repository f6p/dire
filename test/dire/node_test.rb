require 'test_helper'

class Dire::NodeTest < Minitest::Test
  def test_get
    assert_instance_of Dire::Dir,   files
    assert_instance_of Dire::File,  files.get('dune.zip')
    assert_instance_of Dire::Link,  links.get('readme')
    assert_instance_of Dire::Other, root.get('missing', validate: false)

    assert_raises(Dire::Error::InvalidPath) { root.get 'missing' }
  end

  def test_parent
    assert_equal files.root, root.path
    assert_equal links.root, root.path
  end

  def test_to_s
    assert_equal files.relative_path.to_s, files.to_s
  end

  def test_type
    assert_type 'directory', files
    assert_type 'file',      files.get('dune.zip')
    assert_type 'link',      links.get('readme')
    assert_type 'other',     other
  end

  private

  def assert_type kind, node
    assert_equal kind, node.type
  end
end
