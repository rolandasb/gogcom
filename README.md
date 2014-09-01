gogcom [![Gem Version](https://badge.fury.io/rb/gogcom.svg)](http://badge.fury.io/rb/gogcom) [![](https://api.travis-ci.org/rb-/gogcom.svg?branch=develop)](https://travis-ci.org/rb-/gogcom) [![Dependency Status](https://gemnasium.com/rb-/gogcom.svg)](https://gemnasium.com/rb-/gogcom) [![Coverage Status](https://coveralls.io/repos/rb-/gogcom/badge.png?branch=develop)](https://coveralls.io/r/rb-/gogcom?branch=develop)
============

Gogcom is a Ruby library for easy querying gog.com website.

This library is in early stages and not ready for general use.

## Usage

```
gem 'gogcom', '~> 0.0.2'
bundle install
```

```ruby
require 'gogcom'

game = Gogcom.game("Spelunky")

game.title               # => "Spelunky"
game.genres              # => ["Action", "Adventure", "Platformer"]
game.download_size       # => "143 MB"
game.release_date        # => 1375934400 (Unix time)
game.price               # => "$14.99"
game.avg_rating          # => "4.6"
game.avg_ratings_count   # => 268
game.platforms           # => ["Windows"]
game.languages           # => ["English", "French", "Italian", "German", "Spanish"]
game.developer           # => "Mossmouth"
game.publisher           # => "Mossmouth"
game.game_modes          # => ["Single-player", "Multi-player", "Co-op"]

# Reviews right now are limited to 5 (sorted by most helpful, same as in actual website)
game.reviews[0].title    # => "..."
game.reviews[0].rating   # => "..."
game.reviews[0].author   # => "..."
game.reviews[0].body     # => "..."
```

## License

This code is free software; you can redistribute it and/or modify it under the terms of the zlib License. A copy of this license can be found in the included LICENSE file.
