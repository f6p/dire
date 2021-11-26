require 'test_helper'

class DireTest < Minitest::Test
  def test_ignore
    file = 'README'

    assert_equal 1, root.files.size
    ignore(file) { assert_equal 0, root.files.size }

    assert root.get(file)
    assert_raises Dire::Error::InvalidPath do
      ignore(file) { root.get file }
    end
  end

  def test_root
    assert_instance_of Dire::Dir, Dire.root(directory)

    assert_root_error 'files/hello.sh'
    assert_root_error 'links/hello.sh'
    assert_root_error 'non_existing_dir'
  end

  def test_version_number
    refute_nil ::Dire::VERSION
  end

  private

  def assert_root_error path
    assert_raises Dire::Error::InvalidRoot do
      Dire.root File.join(directory, path)
    end
  end

  def ignore pattern, &block
    Dire::IGNORE.push "**/#{pattern}"
    block.call

  rescue Dire::Error::InvalidPath
    raise $!

  ensure
    Dire::IGNORE.pop
  end
end
