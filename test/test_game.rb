require 'helper'

class GogcomTest < Minitest::Test  
  def setup
    @data = Gogcom::Game.get_data("Faster Than Light")
  end

  def test_get_data
    assert @data.is_a?(Hash)
  end

  def test_get_title
    assert_equal Gogcom::Game.get_title(@data), "FTL: Advanced Edition"
  end

  def test_get_genres
    assert_equal Gogcom::Game.get_genres(@data), ["Strategy", "Simulation", "Sci-fi"]
  end

  def test_download_size
    assert_equal Gogcom::Game.get_download_size(@data), "205 MB"
  end

  def test_release_date
    assert_equal Gogcom::Game.get_release_date(@data), 1347595200
  end

  def test_price
    assert_match /^\$\d+(\.\d{2})?$/, Gogcom::Game.get_price(@data)
  end

  def test_avg_ratings
    assert_match /\d.\d/, Gogcom::Game.get_avg_rating(@data).to_s
  end

  def test_avg_ratings_count
    assert_kind_of Integer, Gogcom::Game.get_avg_ratings_count(@data)
  end

  def test_platforms
    assert_equal Gogcom::Game.get_platforms(@data), ["Windows", "Mac"]
  end

  def test_languages
    assert_equal Gogcom::Game.get_languages(@data), ["English"]
  end

  def test_developer
    assert_equal Gogcom::Game.get_developer(@data), "Subset Games"
  end

  def test_publisher
    assert_equal Gogcom::Game.get_publisher(@data), "Subset Games"
  end

  def test_modes
    assert_equal Gogcom::Game.get_modes(@data), ["Single-player"]
  end

  def test_reviews
    assert Gogcom::Game.get_reviews(@data).is_a?(Array)
  end

  def test_get
    game = Gogcom::Game.get("Spelunky")
    assert_kind_of Object, game
  end
end
