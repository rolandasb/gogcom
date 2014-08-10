require 'minitest/autorun'
require 'gogcom'

class GogcomTest < Minitest::Test

	def test_hello
		assert_equal "Hello World", Gogcom.hi
	end

end
