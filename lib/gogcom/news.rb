module Gogcom
	class News
		attr_accessor :title, :link, :body, :date

		def self.get_data()
			data_url = "http://www.gog.com/frontpage/rss" 
			page = Net::HTTP.get(URI(data_url))
			page
		end

		def self.get()
			rss = SimpleRSS.parse self.get_data()
			news = Array.new

			rss.items.each do |item|
				news_item = News.new
				
				news_item.title = item.title
				news_item.link = item.link
				news_item.body = item.description.force_encoding("UTF-8")
				news_item.date = item.pubDate

				news.push news_item
			end

			news
		end
	end
end
