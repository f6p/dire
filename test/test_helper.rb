path = File.expand_path "../lib/#{__dir__}"
$LOAD_PATH.unshift path

require 'minitest/autorun'
require 'dire'
require 'pathname'

def directory
  File.join __dir__, 'root'
end

def root
  Dire.root directory
end

def files
  root.get 'files'
end

def links
  root.get 'links'
end

def node name = 'node'
  path = root.path.join name

  Dire::Node.new path, root.path, validate: false
end

def other name = 'other'
  path = root.path.join name

  Dire::Other.new path, root.path, validate: false
end
