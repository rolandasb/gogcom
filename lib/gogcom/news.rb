module Gogcom
  class News

    def initialize(options)
      @limit = options[:limit] || nil
    end

    # Main method to get news data.
    def get()
      parse(fetch())
    end

    private

    # Fetches raw data from source.
    #
    # @return [String]
    def fetch()
      url = "http://www.gog.com/frontpage/rss"
      page = Net::HTTP.get(URI(url))
      page
    end

    # Parses raw data and returns news items
    #
    # @return [Array]
    def parse(data)
      rss = SimpleRSS.parse data
      news = Array.new

      rss.items.each do |item|
        news_item = NewsItem.new(item.title, item.link, item.description.force_encoding("UTF-8"), item.pubDate)

        news.push news_item
      end

      unless @limit.nil?
        news.take(@limit)
      else
        news
      end
    end
  end

  class NewsItem < Struct.new(:title, :link, :body, :date)
  end
end
