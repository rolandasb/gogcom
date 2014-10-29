require 'helper'

class GogcomGameTest < Minitest::Test  
  def setup
    VCR.use_cassette('game') do
      @game = Gogcom.game(:name => "Faster Than Light")
    end
  end

  def test_game
    assert @game.is_a?(Struct)
  end

  def test_game_title
    assert_equal @game.title, "FTL: Advanced Edition"
  end

  def test_game_genres
    assert_equal @game.genres, ["Strategy", "Simulation", "Sci-fi"]
  end

  def test_game_download_size
    assert_equal @game.download_size, "205 MB"
  end

  def test_game_release_date
    assert_equal @game.release_date, 1347595200
  end

  def test_game_description
    assert_kind_of String, @game.description
  end

  def test_game_price
    assert_match /^\$\d+(\.\d{2})?$/, @game.price
  end

  def test_game_avg_ratings
    assert_match /\d.\d/, @game.avg_rating.to_s
  end

  def test_game_avg_ratings_count
    assert_kind_of Integer, @game.avg_ratings_count
  end

  def test_game_platforms
    assert_equal @game.platforms, ["Windows", "Mac"]
  end

  def test_game_pegi_age
    assert_equal @game.pegi_age, false
  end

  def test_game_languages
    assert_equal @game.languages, ["English"]
  end

  def test_game_developer
    assert_equal @game.developer, "Subset Games"
  end

  def test_game_publisher
    assert_equal @game.publisher, "Subset Games"
  end

  def test_game_modes
    assert_equal @game.game_modes, ["Single-player"]
  end

  def test_game_bonus_content
    assert_equal @game.bonus_content, ["wallpaper", "soundtrack sample (5 tracks)", "avatars", "artworks"]
  end

  def test_game_reviews
    assert @game.reviews.is_a?(Array)
  end
end
