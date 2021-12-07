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
end
