Dire
====

Simple `Pathname` wrapper that provides convenient
and safe interface for filesystem traversal.

Useful in situations where you need to accept parameters
from external sources (like HTTP request) or read data from
potentially unsafe directory structure (containing symbolic
links).

Main Features:
--------------

* simple interface,
* easy to test,
* restrict access to selected directory (paths, links),
* content type recognition (binary, mime),
* ignore pattern support.

Sample Usage:
-------------

Restrict access to directory:

```ruby
root = Dire.root 'path/to/dir'
=> #<Dire::Dir>
```

Basic `Dire::Dir` methods:

```ruby
dir = root.get 'path/to/subdir'
=> #<Dire::Dir>

dir.dirs
=> [#<Dire::Dir>, #<Dire::Dir>, ...]

dir.files
=> [#<Dire::File>, #<Dire::File>, ...]

root.list
=> [#<Dire::Dir>, #<Dire::File>, ...]
```

Basic `Dire::File` methods:

```ruby
file = dir.get 'path/to/file.txt'
=> #<Dire::File>

# check data encoding
file.binary?
=> false

# get MimeMagic (mimemagic gem)
file.mime
=> #<MimeMagic>

# inverse of binary
file.text?
=> true
```

Common `Dire::Node` methods:

```ruby
# associated Pathname (for IO use)
file.path
=> #<Pathname>

# alias of path
file.absolute_path
=> #<Pathname>

# relative as string
file.param
=> #<String>

# relative to root
file.relative_path
=> #<Pathname>
```

Ignore patterns:

```ruby
Dire::IGNORE << 'globbing/pattern'

# raises Dire::Error::InvalidPath
dir.get 'path/matching/pattern'
```

For more information check [lib](https://github.com/f6p/dire/tree/master/lib)
and [test](https://github.com/f6p/dire/tree/master/test).

Rails Usage:
------------

Add `dire` gem.

Add route:

```ruby
get 'controller_path(/:path_parameter)',
  as: 'route_name',
  to: 'controller_name#action_name',
  constraints: { path: /.+/ },
  format: false
```

Force HTML:

```ruby
before_action :force_html, only: 'action_name'

def force_html
 request.format = :html
end
```
