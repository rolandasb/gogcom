require 'helper'

class GogcomTest < Minitest::Test
  def test_urlfy
    assert_equal "faster_than_light", Gogcom::Func.urlfy("Faster Than Light")
  end
end
