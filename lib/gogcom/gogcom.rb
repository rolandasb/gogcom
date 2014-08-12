class Gogcom

  GOG_GAME_BASE_URL = "http://www.gog.com/game/"

  def self.game(name)
    name = urlfy_name(name)
    page = Nokogiri::HTML(open(GOG_GAME_BASE_URL + name))

    game = Game.new

    # Game title
    title_raw = page.css('title').text
    game.title = title_raw.slice(0..(title_raw.index('for download')-2))

    # Game genres
    game.genres = []
    genres_raw = page.css('ul.game-specification li')[0].css('.data b')
    genres_raw.each do |genre|
      game.genres.push(genre.css('a').text)
    end

    # Download size
    game.download_size = page.css('ul.game-specification li.download_size .data b')[0].text
    
    # Release date
    game.release_date = page.css('ul.game-specification li')[3].css('.data')[0].text

    # Price
    price = page.css('form #game_price').attr('value').text
    game.price = "$" + (price.to_f / 100).to_s

    # Average rating
    game.avg_rating = 0.0
    avg_rating_raw = page.css('ul.game-specification li')[2].css('.data .usr_rate span')
    avg_rating_raw.each do |star|      
      if star.attr('class') == 'usr_s_f'
        game.avg_rating += 1.0
      elsif star.attr('class') == 'usr_s_h'
        game.avg_rating += 0.5
      end
    end

    # Rating count
    if page.css('ul.game-specification li')[2].css('.data span')[0].attr('class') != "vdark_un"
      avg_ratings_count_raw = page.css('ul.game-specification li')[2].css('.data span')[6].text
      game.avg_ratings_count = avg_ratings_count_raw.gsub(/\D/, '').to_i
    else
      game.avg_ratings_count = nil
    end

    # Platforms
    game.platforms = []
    platforms_raw = page.css('ul.game-specification li')[4].css('.data')[0].text
    game.platforms = platforms_raw.split(' and ')

    # Languages
    languages_raw = page.css('ul.game-specification li')[5].css('.data').text
    game.languages = languages_raw.gsub("Audio and text:", "").gsub("Text only:", "")
                                  .gsub(/\s+/, '').gsub('.', ',').split(',')

    game.developer = page.css('ul.game-specification li')[6].css('.data a')[0].text   # Developer
    game.publisher = page.css('ul.game-specification li')[6].css('.data a')[0].text   # Publisher
    
    # Game modes
    game.game_modes = []
    game_modes_raw = page.css('ul.game-specification li')[7].css('.data')[0].text
    game_modes_raw = game_modes_raw.gsub(/\s+/, '') # Remove whitespaces
    game.game_modes = game_modes_raw.split(',')

    # Reviews
    game.reviews = []
    reviews_list_raw = page.css('#reviewsList #reviewsHolder .user_rev')
    reviews_list_raw.each do |review|
      if review.attr('class') != "user_rev empty"
        r = Review.new
        
        r.title = review.css('h4').text
        
        r.rating = 0.0;
        ratings = review.css('.usr_rate span')
        ratings.each do |star|      
          if star.attr('class') == 'usr_s_f'
            r.rating += 1.0
          elsif star.attr('class') == 'usr_s_h'
            r.rating += 0.5
          end
        end

        # date
        details = review.css('.details').text
        r.date = details.gsub('Posted on ', '').gsub(/ by\w+:/, '')

        # User
        r.user = details.gsub(/^(.+?) by/, '').gsub(':', '')

        # Body
        body = review.css('.text').text
        r.body = body.gsub('read more', '')

        game.reviews.push(r)
      end
    end

    game
  end

  # Converts Game: Name 2 to game_name_2
  # @param: game name {string}
  # @return: converted game name {string}
  def self.urlfy_name(name)
    name = name.gsub(/[^0-9A-Za-z\s]/, '').gsub(/\s/, '_').downcase
    return name
  end
end
