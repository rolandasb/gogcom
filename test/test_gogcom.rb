require 'minitest/autorun'
require 'gogcom'

class GogcomTest < MiniTest::Test
	def setup
		@game = Gogcom.game("Faster Than Light")
	end

	# Game
	def test_that_game_has_genres
		assert_equal ["strategy", "simulation", "sci-fi"], @game.genres
	end

	def test_that_game_has_download_size
		assert_equal "205 MB", @game.download_size
	end

	def test_that_game_has_release_date
		assert_equal "September 14, 2012", @game.release_date
	end

end
