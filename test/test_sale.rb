require 'helper'

class GogcomSaleTest < Minitest::Test
  def setup
    VCR.use_cassette('index') do
      @data = Gogcom::Sale.get_data
    end

    @game_id = 0 # Index of gamelist array
  end

  def test_get_data
    assert @data.is_a?(Hash)
  end

  def test_get_title
    assert_equal Gogcom::Sale.get_title(@data, @game_id), "Witcher 3: Wild Hunt, The - preorder"
  end

  def test_get_price_current
    assert_equal Gogcom::Sale.get_price_current(@data, @game_id), "$53.99"
  end

  def test_get_price_original
    assert_equal Gogcom::Sale.get_price_original(@data, @game_id), "$59.99"
  end

  def test_get_discount_percentage
    assert_equal Gogcom::Sale.get_discount_percentage(@data, @game_id), 10
  end

  def test_discount_amount
    assert_equal Gogcom::Sale.get_discount_amount(@data, @game_id), "$6.00"
  end

  def test_is_game?
    assert_equal Gogcom::Sale.is_game?(@data, @game_id), true 
  end
  
  def test_is_movie?
    assert_equal Gogcom::Sale.is_movie?(@data, @game_id), false
  end

  def test_get
    VCR.use_cassette('index') do
      sale = Gogcom::Sale.get
      assert_kind_of Object, sale
    end
  end
end
