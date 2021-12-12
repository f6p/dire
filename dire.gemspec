require_relative 'lib/dire/version'

Gem::Specification.new do |spec|
  spec.name     = 'dire'
  spec.version  = Dire::VERSION

  spec.authors = ['Filip Pyda']
  spec.email   = ['filip.pyda@gmail.com']

  spec.summary     = 'File Browser'
  spec.description = 'Pathname wrapper for safe and convenient filesystem traversal.'
  spec.homepage    = 'https://github.com/f6p/dire'
  spec.license     = 'MIT'

  spec.add_dependency 'mimemagic', '~> 0.4.3'
  spec.add_dependency 'zeitwerk',  '~> 2.5.1'

  spec.add_development_dependency 'minitest', '~> 5.14.4'

  spec.files = Dir['lib/**/*']

  spec.extra_rdoc_files = %w(
    README.md
    LICENSE.txt
  )
end
