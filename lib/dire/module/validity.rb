module Dire::Module::Validity
  def validate!
    begin
      if ignore? path
        raise Errno::ENOENT if ignore? path
      end

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

  def validate_type! name
    unless type == name
      raise Dire::Error::InvalidPath, 'Node missmatch'
    end

    true
  end
end
