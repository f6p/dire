module Dire::Mixin::Check
  def == other
    path.to_s == other.path.to_s
  end

  def broken?
    false
  end

  def known?
    true
  end

  def parent? node
    parent == node
  end

  def root?
    false
  end

  def validate!
    begin
      raise Errno::ENOENT if ignore? path

      path.lstat
    rescue Errno::ENOENT
      raise Dire::Error::InvalidPath, 'Not found'
    end

    unless inside? path
      raise Dire::Error::InvalidPath, 'Outside root'
    end

    true
  end

  private

  def ignore? path
    Dire::IGNORE.any? do |ignore|
      File.fnmatch? ignore, path, File::FNM_PATHNAME
    end
  end

  def inside? path
    expand(path).to_s.index(root.to_s) == 0
  end

  def validate_type! name
    unless type == name
      raise Dire::Error::InvalidPath, 'Node missmatch'
    end

    true
  end
end
