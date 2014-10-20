require 'helper'

class GogcomNewsTest < Minitest::Test
	def setup
		VCR.use_cassette('news') do
			@data = Gogcom::News.get_data
		end
	end

	def test_parse_data
		news = Gogcom::News.parse_data(@data)
		assert news.is_a?(Array)
	end

	def test_parse_data_limit
		news = Gogcom::News.parse_data(@data, :limit => 2)
		assert news.is_a?(Array)
		assert_equal 2, news.count
	end
end
