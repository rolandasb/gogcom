class GogcomTest < Minitest::Test
  def test_game
    game = Gogcom.game("Spelunky")
    assert_kind_of Object, game
  end
end
