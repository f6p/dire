module Dire::Module::Path
  def absolute_path
    path
  end

  def name
    absolute_path.basename.to_s
  end

  def param
    relative_path.to_s
  end

  def relative_path
    chop path
  end

  private

  def chop pth
    expand(pth).relative_path_from(root)
  end

  def expand pth
    path.join(pth).expand_path
  end

  def ignore? path
    Dire::IGNORE.any? do |ignore|
      File.fnmatch? ignore, path, File::FNM_DOTMATCH | File::FNM_PATHNAME
    end
  end

  def inside? path
    expand(path).to_s.index(root.to_s) == 0
  end
end
