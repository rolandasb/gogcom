require 'minitest/autorun'
require 'gogcom'

class GogcomTest < Minitest::Test

	def test_hello
		assert_equal "Hello ", Gogcom.hi
	end

	def test_world
		assert_equal "World", Gogcom.world
	end

end
