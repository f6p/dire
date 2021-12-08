require 'test_helper'

class Dire::LinkTest < Minitest::Test
  def test_broken
    path = links.path.join 'broken'
    link = Dire::Link.new path, root.path, validate: false

    assert link.broken?

    refute links.get('files').broken?
    refute links.get('readme').broken?
  end

  def test_param
    assert_link 'files',  'files'
    assert_link 'README', 'readme'
  end

  def test_validate
    assert links.get('readme')

    assert_raises Dire::Error::InvalidPath do
      Dire::Link.new files.path, root.path
    end

    assert_raises Dire::Error::InvalidLink do
      links.get 'broken'
    end
  end

  private

  def assert_link target, link
    assert_equal target, links.get(link).param
  end
end
