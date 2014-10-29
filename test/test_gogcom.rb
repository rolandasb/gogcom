class GogcomTest < Minitest::Test
  def test_game
    VCR.use_cassette('game') do
      game = Gogcom.game(:name => "Faster Than Light")
      assert_kind_of Struct, game
    end
  end

  def test_sale
    VCR.use_cassette('index') do
      sale = Gogcom.sale
      assert_kind_of Array, sale
    end
  end
  
  def test_news
    VCR.use_cassette('news') do
      news = Gogcom.news
      assert_kind_of Array, news
    end
  end
end
