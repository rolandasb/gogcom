module Gogcom
	class News
		attr_accessor :title, :link, :body, :date

		def self.get_data()
			data_url = "http://www.gog.com/frontpage/rss" 
			page = Net::HTTP.get(URI(data_url))
			page
		end

		def self.parse_data(data, options = {})
			rss = SimpleRSS.parse data
			news = Array.new
			limit = options[:limit] || nil
			count = 0

			rss.items.each do |item|
				news_item = News.new
				
				news_item.title = item.title
				news_item.link = item.link
				news_item.body = item.description.force_encoding("UTF-8")
				news_item.date = item.pubDate

				news.push news_item
				count += 1
				
				break if !limit.nil? && count >= limit
			end

			news
		end

		def self.get(options)
			self.parse_data(self.get_data(), options)
		end
	end
end
