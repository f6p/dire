require 'test_helper'

class Dire::FileTest < Minitest::Test
  def test_binary
    assert files.get('dune.zip').binary?

    refute files.get('script.rb').binary?
  end

  def test_mime
    mime = files.get('script.rb').mime

    assert_instance_of MimeMagic, mime

    assert_equal 'application/x-ruby', mime.type
    assert_equal 'application', mime.mediatype
    assert_equal 'x-ruby', mime.subtype

    refute files.get('empty').mime
  end

  def test_text
    assert files.get('script.rb').text?

    refute files.get('dune.zip').text?
  end

  def test_validate
    assert files.get('dune.zip')

    assert_raises Dire::Error::InvalidPath do
      Dire::File.new files.path, root.path
    end
  end
end
