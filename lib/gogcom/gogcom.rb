class Gogcom

	GOG_GAME_BASE_URL = "http://www.gog.com/game/"

	def self.game(name)
		name = urlfy_name(name)
		page = Nokogiri::HTML(open(GOG_GAME_BASE_URL + name))

		game = Game.new

		# Game genres
		game.genres = []
		genres_raw = page.css('ul.game-specification li')[0].css('.data b')
		genres_raw.each do |genre|
			game.genres.push(genre.css('a').text)
		end

		game.download_size = page.css('ul.game-specification li.download_size .data b')[0].text 	# Download size
		game.release_date = page.css('ul.game-specification li')[3].css('.data')[0].text 					# Release date
		
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