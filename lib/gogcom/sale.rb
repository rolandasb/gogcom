module Gogcom
  class Sale

    def initialize(options)
      @type = options[:type] || nil
      @limit = options[:limit] || nil
    end

    # Main method to get sales data.
    def get()
      parse(fetch())
    end

    private

    # Fetches raw data from source.
    #
    # @return [Object]
    def fetch()
      url = "http://www.gog.com/"
      page = Net::HTTP.get(URI(url))
      @data = JSON.parse(page[/(?<=var gogData = )(.*)(?=;)/,1])
    end

    # Parses raw data and returns sale items.
    #
    # @return [Array]
    def parse(data)
      items = []

      data["on_sale"].each do |item|
        sale_item = SaleItem.new(get_title(item), get_price_current(item),
          get_price_original(item), get_discount_percentage(item),
          get_discount_amount(item))

        if @type.nil?
          items.push(sale_item)
        else
          if (@type == "games" && is_game?(item))
            items.push(sale_item)
          end

          if (@type == "movies" && is_movie?(item))
            items.push(sale_item)
          end
        end
      end

      unless @limit.nil?
        items.take(@limit)
      else
        items
      end
    end 

    def get_title(data)
      data["title"]
    end

    def get_price_current(data)
      data["price"]["symbol"] + data["price"]["amount"]
    end

    def get_price_original(data)
      data["price"]["symbol"] + data["price"]["baseAmount"]
    end

    def get_discount_percentage(data)
      data["price"]["discountPercentage"]
    end

    def get_discount_amount(data)
      data["price"]["symbol"] + data["price"]["discountDifference"]
    end

    def is_game?(data)
      data["isGame"]
    end

    def is_movie?(data)
      data["isMovie"]
    end
  end

  class SaleItem < Struct.new(:title, :price_current, :price_original,
    :discount_percentage, :discount_amount, :isGame, :isMovie)
  end
end
