class GogcomTest < Minitest::Test
  def test_game
    VCR.use_cassette('game') do
      game = Gogcom.game("Faster Than Light")
      assert_kind_of Object, game
    end
  end

  def test_sale
    VCR.use_cassette('index') do
      sale = Gogcom.sale
      assert_kind_of Array, sale
    end
  end
end
