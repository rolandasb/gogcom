gogcom [![Gem Version](https://badge.fury.io/rb/gogcom.svg)](http://badge.fury.io/rb/gogcom) [![Build Status](https://travis-ci.org/rbrs/gogcom.svg?branch=develop)](https://travis-ci.org/rbrs/gogcom) [![Dependency Status](https://gemnasium.com/rbrs/gogcom.svg)](https://gemnasium.com/rbrs/gogcom) [![Coverage Status](https://coveralls.io/repos/rb-/gogcom/badge.png?branch=develop)](https://coveralls.io/r/rb-/gogcom?branch=develop)
============

Gogcom is a Ruby library for easy querying gog.com website.

This library is in early stages and not ready for production use.

## Usage

#### Installation
```
gem 'gogcom', '~> 0.0.25'
bundle install
```

#### Get game info
```ruby
require 'gogcom'

game = Gogcom.game("Spelunky")

game.title               # => "Spelunky"
game.genres              # => ["Action", "Adventure", "Platformer"]
game.download_size       # => "143 MB"
game.release_date        # => 1375934400 (Unix time)
game.description         # => "..."
game.price               # => "$14.99"
game.avg_rating          # => "4.6"
game.avg_ratings_count   # => 268
game.platforms           # => ["Windows"]
game.languages           # => ["English", "French", "Italian", "German", "Spanish"]
game.pegiAge             # => false
game.developer           # => "Mossmouth"
game.publisher           # => "Mossmouth"
game.bonus_content       # => [...]
game.game_modes          # => ["Single-player", "Multi-player", "Co-op"]

# Reviews right now are limited to 5 (sorted by most helpful, same as in actual website)
game.reviews.each do |review|
	review.title
	review.rating
	review.author
	review.body
end
```

#### Get games on sale
```ruby
require 'gogcom'

sale = Gogcom.sale
# sale = Gogcom.sale(:type => "games")
# sale = Gogcom.sale(:type => "movies")

sale.each do |game|
	game.title
	game.price_current
	game.price_original
	game.discount_percentage
	game.discount_amount
end
```

#### Get news
```ruby
require 'gogcom'

news = Gogcom.news
# news = Gogcom.news(:limit => 3)

news.each do |post|
  post.title
  post.link
  post.body
  post.date
end
```

## License

This code is free software; you can redistribute it and/or modify it under the terms of the zlib License. A copy of this license can be found in the included LICENSE file.
