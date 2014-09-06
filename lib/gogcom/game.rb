module Gogcom
  class Game
    attr_accessor :title, :genres, :download_size, :release_date, :description, :price, :avg_rating,
                :avg_ratings_count, :platforms, :pegiAge, :languages, :developer, :publisher,
                :game_modes, :reviews

    def self.get_data(game_name)
      name = Gogcom::Func.urlfy(game_name)
      page = Net::HTTP.get(URI("http://www.gog.com/game/" + name))
      data = JSON.parse(page[/(?<=var gogData = )(.*)(?=;)/,1])
      data
    end

    def self.get_title(data)
      data["gameProductData"]["title"]
    end

    def self.get_genres(data)
      genres = []
      genres_raw = data["gameProductData"]["genres"]    
      genres_raw.each do |genre|
        genres.push(genre["name"])
      end

      genres
    end

    def self.get_download_size(data)
      data["gameProductData"]["downloadSize"]
    end

    def self.get_release_date(data)
      data["gameProductData"]["releaseDate"]
    end

    def self.get_description(data)
      data["gameProductData"]["description"]["full"]
    end

    def self.get_price(data)
      data["gameProductData"]["price"]["symbol"] + data["gameProductData"]["price"]["amount"]
    end

    def self.get_avg_rating(data)
      data["gameProductData"]["rating"].to_s.insert(1, ".")
    end

    def self.get_avg_ratings_count(data)
      data["gameProductData"]["votesCount"]
    end

    def self.get_platforms(data)
      platforms = []
      platforms_raw = data["gameProductData"]["worksOn"]
      platforms_raw.each do |platform|
        if(platform[1])
          platforms.push(platform[0])
        end
      end

      platforms
    end

    def self.get_languages(data)
      data["gameProductData"]["languages"]
    end

    def self.get_developer(data)
      data["gameProductData"]["developer"]["name"]
    end

    def self.get_publisher(data)
      data["gameProductData"]["publisher"]["name"]
    end

    def self.get_modes(data)
      game_modes = []
      modes_raw = data["gameProductData"]["modes"]
      modes_raw.each do |mode|
        game_modes.push(mode["title"])
      end

      game_modes
    end

    def self.get_reviews(data)
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

    def self.get_pegiAge(data)
      data["gameProductData"]["pegiAge"] 
    end

    def self.get(game_name)
      data = self.get_data(game_name)
      game = Game.new

      game.title = get_title(data)
      game.genres = get_genres(data)
      game.download_size = get_download_size(data)
      game.release_date = get_release_date(data)
      game.description = get_description(data)
      game.price = get_price(data)
      game.avg_rating = get_avg_rating(data)
      game.avg_ratings_count = get_avg_ratings_count(data)
      game.platforms = get_platforms(data)
      game.pegiAge = get_pegiAge(data)
      game.languages = get_languages(data)
      game.developer = get_developer(data)
      game.publisher = get_publisher(data)
      game.game_modes = get_modes(data)
      game.reviews = get_reviews(data)

      game
    end
  end
end
