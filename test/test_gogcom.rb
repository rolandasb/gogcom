class GogcomTest < Minitest::Test
  def test_game
    VCR.use_cassette('game') do
      game = Gogcom.game("Faster Than Light")
      assert_kind_of Object, game
    end
  end
end
