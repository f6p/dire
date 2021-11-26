require 'zeitwerk'

loader = Zeitwerk::Loader.for_gem
loader.setup

module Dire
  IGNORE=%w()

  def self.root path
    Dire::Dir.new path, path
  end
end
