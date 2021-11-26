module Dire::Mixin::Path
  def absolute_path
    path
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
end
