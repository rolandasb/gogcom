module Gogcom
  class Game

    def initialize(options)
      @name = options[:name] || nil
    end

    # Main method to get game data
    def get()
      parse(fetch())
    end

    private

    # Fetches raw data and parses as JSON object
    #
    # @return [Object]
    def fetch()
      name = urlfy(@name)
      page = Net::HTTP.get(URI("http://www.gog.com/game/" + name))
      data = JSON.parse(page[/(?<=var gogData = )(.*)(?=;)/,1])
      data
    end

    # Parses raw data and returns game item.
    #
    # @param [Object]
    # @return [Struct]
    def parse(data)
      game = GameItem.new(get_title(data), get_genres(data),
        get_download_size(data), get_release_date(data), get_description(data),
        get_price(data), get_avg_rating(data), get_avg_ratings_count(data),
        get_platforms(data), get_languages(data), get_developer(data),
        get_publisher(data), get_modes(data), get_bonus_content(data),
        get_reviews(data), get_pegi_age(data))      

      game
    end

    def get_title(data)
      data["gameProductData"]["title"]
    end

    def get_genres(data)
      genres = []
      genres_raw = data["gameProductData"]["genres"]    
      genres_raw.each do |genre|
        genres.push(genre["name"])
      end

      genres
    end

    def get_download_size(data)
      data["gameProductData"]["downloadSize"]
    end

    def get_release_date(data)
      data["gameProductData"]["releaseDate"]
    end

    def get_description(data)
      data["gameProductData"]["description"]["full"]
    end

    def get_price(data)
      data["gameProductData"]["price"]["symbol"] + data["gameProductData"]["price"]["amount"]
    end

    def get_avg_rating(data)
      data["gameProductData"]["rating"].to_s.insert(1, ".")
    end

    def get_avg_ratings_count(data)
      data["gameProductData"]["votesCount"]
    end

    def get_platforms(data)
      platforms = []
      platforms_raw = data["gameProductData"]["worksOn"]
      platforms_raw.each do |platform|
        if(platform[1])
          platforms.push(platform[0])
        end
      end

      platforms
    end

    def get_languages(data)
      data["gameProductData"]["languages"]
    end

    def get_developer(data)
      data["gameProductData"]["developer"]["name"]
    end

    def get_publisher(data)
      data["gameProductData"]["publisher"]["name"]
    end

    def get_modes(data)
      game_modes = []
      modes_raw = data["gameProductData"]["modes"]
      modes_raw.each do |mode|
        game_modes.push(mode["title"])
      end

      game_modes
    end

    def get_bonus_content(data)
      bonusContent = []
      bonusContent_raw = data["gameProductData"]["bonusContent"]
      
      bonusContent_raw["hidden"].each do |bc|
        bonusContent.push(bc["name"])
      end

      bonusContent_raw["visible"].each do |bc|
        bonusContent.push(bc["name"])
      end

      bonusContent
    end

    def get_reviews(data)
      reviews = []
      reviews_raw = data["reviews"]["pages"][0]
      reviews_raw.each do |review|
        r = Review.new

        r.title = review["title"]
        r.rating = review["rating"].to_s.insert(1, ".")
        r.author = review["author"]["name"]
        r.body = review["description"]
        
        reviews.push(r)
      end

      reviews
    end

    def get_pegi_age(data)
      data["gameProductData"]["pegiAge"] 
    end

    # Converts "Game Name" to "game_name"
    # 
    # @param [String]
    # @return [String]
    def urlfy(name)
      name = name.gsub(/[^0-9A-Za-z\s]/, '').gsub(/\s/, '_').downcase
      name
    end
  end

  class GameItem < Struct.new(:title, :genres, :download_size, :release_date,
    :description, :price, :avg_rating, :avg_ratings_count, :platforms,
    :languages, :developer, :publisher, :game_modes, :bonus_content, :reviews,
    :pegiAge)
  end

  class Review < Struct.new(:title, :rating, :author, :body)
  end
end
