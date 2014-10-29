require 'helper'

class GogcomSaleTest < Minitest::Test
  def setup
    VCR.use_cassette('index') do
      @items = Gogcom.sale()
    end

    VCR.use_cassette('index') do
      @items_type_games = Gogcom.sale(type: "games")
    end

    VCR.use_cassette('index') do
      @items_type_movies = Gogcom.sale(type: "movies")
    end

    VCR.use_cassette('index') do
      @items_limit = Gogcom.sale(limit: 2)
    end
  end

  def test_sale
    assert @items.is_a?(Array)
  end

  def test_sale_type_games
    assert @items_type_games.is_a?(Array)
  end

  def test_sale_type_movies
    assert @items_type_movies.is_a?(Array)
  end

  def test_sale_limit
    assert @items_limit.is_a?(Array)
    assert_equal @items_limit.count, 2
  end

  def test_sale_title
    assert_equal @items.first.title, "Witcher 3: Wild Hunt, The - preorder"
  end

  def test_sale_current_price
    assert_equal @items.first.current_price, "$53.99"
  end

  def test_sale_original_price
    assert_equal @items.first.original_price, "$59.99"
  end

  def test_sale_discount_percentage
    assert_equal @items.first.discount_percentage, 10
  end

  def test_discount_amount
    assert_equal @items.first.discount_amount, "$6.00"
  end
end
