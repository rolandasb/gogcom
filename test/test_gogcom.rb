require 'minitest/autorun'
require 'helper'
require 'gogcom'

class GogcomTest < MiniTest::Test
  def setup
    @game = Gogcom.game("Faster Than Light")
  end

  # Game
  def test_that_game_has_title
    assert_equal "FTL: Advanced Edition", @game.title
  end

  def test_that_game_has_genres
    assert_equal ["strategy", "simulation", "sci-fi"], @game.genres
  end

  def test_that_game_has_download_size
    assert_equal "205 MB", @game.download_size
  end

  def test_that_game_has_release_date
    assert_equal "September 14, 2012", @game.release_date
  end

  def test_that_game_has_price
    assert_match /^\$\d+(\.\d{2})?$/, @game.price
  end

  def test_that_game_has_avg_rating
    assert_match /\d.\d/, @game.avg_rating.to_s
  end

  def test_that_game_has_avg_ratings_number
    assert_kind_of Integer, @game.avg_ratings_count
  end

  def test_that_game_has_platforms
    assert_equal ["Windows (XP, Vista, 7, 8)", "Mac OS X (10.6.8 or newer)"], @game.platforms
  end

  def test_that_game_has_languages
    assert_equal ["English"], @game.languages
  end

  def test_that_game_has_developer
    assert_equal "Subset Games", @game.developer
  end

  def test_that_game_has_publisher
    assert_equal "Subset Games", @game.publisher
  end

  def test_that_game_has_game_modes
    assert_equal ["single-player"], @game.game_modes
  end

  def test_that_game_has_reviews
    assert !@game.reviews.empty?, "Reviews array is empty"
  end

end
