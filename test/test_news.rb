require 'helper'

class GogcomNewsTest < Minitest::Test
	def setup
		VCR.use_cassette('news') do
			@news = Gogcom.news()
		end

		VCR.use_cassette('news') do
			@news_limit = Gogcom.news(:limit => 2)
		end
	end

	def test_news
		assert @news.is_a?(Array)
	end

	def test_news_limit
		assert @news_limit.is_a?(Array)
		assert @news_limit.count, 2
	end
end
