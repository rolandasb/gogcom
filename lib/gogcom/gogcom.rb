class Gogcom

  GOG_GAME_BASE_URL = "http://www.gog.com/game/"

  def self.game(name)
    name = urlfy_name(name)
    page = Nokogiri::HTML(open(GOG_GAME_BASE_URL + name))
    data = JSON.parse(page.css('script')[0].text.gsub(/^\s+|\s+$/, "").gsub("var gogData = ", "")[0..-2])

    game = Game.new

    # Game title
    game.title = data["gameProductData"]["title"]

    # Game genres
    game.genres = []
    genres_raw = data["gameProductData"]["genres"]    
    genres_raw.each do |genre|
      game.genres.push(genre["name"])
    end

    # Download size
    game.download_size = data["gameProductData"]["downloadSize"]
    
    # Release date
    game.release_date = data["gameProductData"]["releaseDate"]

    # Price
    game.price = data["gameProductData"]["price"]["symbol"] + data["gameProductData"]["price"]["amount"]

    # Average rating
    game.avg_rating = data["gameProductData"]["rating"].to_s.insert(1, ".")

    # Rating count
    game.avg_ratings_count = data["gameProductData"]["votesCount"]

    # Platforms
    game.platforms = []
    platforms_raw = data["gameProductData"]["worksOn"]
    platforms_raw.each do |platform|
      if(platform[1])
        game.platforms.push(platform[0])
      end
    end

    # Languages
    game.languages = data["gameProductData"]["languages"]

    # Developer & Publisher
    game.developer = data["gameProductData"]["developer"]["name"]
    game.publisher = data["gameProductData"]["publisher"]["name"]
    
    # Game modes
    game.game_modes = []
    modes_raw = data["gameProductData"]["modes"]
    modes_raw.each do |mode|
      game.game_modes.push(mode["title"])
    end

    # Reviews
    game.reviews = []
    reviews_raw = data["reviews"]["pages"][0]
    reviews_raw.each do |review|
      r = Review.new

      r.title = review["title"]
      r.rating = review["rating"].to_s.insert(1, ".")
      r.author = review["author"]["name"]
      r.body = review["description"]
      
      game.reviews.push(r)
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
