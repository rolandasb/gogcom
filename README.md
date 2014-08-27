gogcom [![Gem Version](https://badge.fury.io/rb/gogcom.svg)](http://badge.fury.io/rb/gogcom) [![](https://api.travis-ci.org/rb-/gogcom.svg?branch=develop)](https://travis-ci.org/rb-/gogcom) [![Dependency Status](https://gemnasium.com/rb-/gogcom.svg)](https://gemnasium.com/rb-/gogcom) [![Coverage Status](https://coveralls.io/repos/rb-/gogcom/badge.png?branch=develop)](https://coveralls.io/r/rb-/gogcom?branch=develop)
============

Gogcom is a Ruby library for easy querying gog.com website.

This library is in early stages and not ready for general use.

**WARNING** 2014-08-27 Due recent changes to gog.com website the library is completely unusable. It probably won't be updated till gog will have a working api.

## Usage

```
gem 'gogcom', '~> 0.0.1'
bundle install
```

```ruby
require 'gogcom'

game = Gogcom.game("Spelunky")

game.title               # => "Spelunky"
game.genres              # => ["action", "adventure", "platformer"]
game.download_size       # => "143 MB"
game.release_date        # => "August 8, 2013"
game.price               # => "$14.99"
game.avg_rating          # => 4.5
game.avg_ratings_count   # => 257
game.platforms           # => ["Windows (XP, Vista, 7, 8)"]
game.languages           # => ["English", "French", "Italian", "German", "Spanish"]
game.developer           # => "Mossmouth"
game.publisher           # => "Mossmouth"
game.game_modes          # => ["single-player", "multi-player", "co-op"]
```

## License

This code is free software; you can redistribute it and/or modify it under the terms of the zlib License. A copy of this license can be found in the included LICENSE file.
