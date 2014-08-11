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
		stuff_raw = page.css('ul.game-specification li')[2].css('.data .usr_rate span')
		stuff_raw.each do |star|			
			if star.attr('class') == 'usr_s_f'
				game.avg_rating += 1.0
			elsif star.attr('class') == 'usr_s_h'
				game.avg_rating += 0.5
			end
		end

		# Rating count
		avg_ratings_count_raw = page.css('ul.game-specification li')[2].css('.data span')[6].text
		game.avg_ratings_count = avg_ratings_count_raw.gsub(/\D/, '').to_i

		# Platforms
		game.platforms = []
		platforms_raw = page.css('ul.game-specification li')[4].css('.data')[0].text
		game.platforms = platforms_raw.split(' and ')

		# Languages
		languages_raw = page.css('ul.game-specification li')[5].css('.data').text
		game.languages = languages_raw.gsub("Audio and text:", "").gsub("Text only:", "")
																	.gsub(/\s+/, '').gsub('.', ',').split(',')

		game.developer = page.css('ul.game-specification li')[6].css('.data a')[0].text 	# Developer
		game.publisher = page.css('ul.game-specification li')[6].css('.data a')[0].text 	# Publisher
		
		# Game modes
		game.game_modes = []
		game_modes_raw = page.css('ul.game-specification li')[7].css('.data')[0].text
		game_modes_raw = game_modes_raw.gsub(/\s+/, '') # Remove whitespaces
		game.game_modes = game_modes_raw.split(',')

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
