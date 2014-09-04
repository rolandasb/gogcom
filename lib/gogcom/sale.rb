module Gogcom
  class Sale
    attr_accessor :title, :price_current, :price_original, :discount_percentage,
                  :discount_amount

    def self.get_data
      page = Net::HTTP.get(URI("http://www.gog.com/"))
      data = JSON.parse(page[/(?<=var gogData = )(.*)(?=;)/,1])
      data
    end

    def self.get_title(data, i)
      data["on_sale"][i]["title"]
    end

    def self.get_price_current(data, i)
      data["on_sale"][i]["price"]["symbol"] + data["on_sale"][i]["price"]["amount"]
    end

    def self.get_price_original(data, i)
      data["on_sale"][i]["price"]["symbol"] + data["on_sale"][i]["price"]["baseAmount"]
    end

    def self.get_discount_percentage(data, i)
      data["on_sale"][i]["price"]["discountPercentage"]
    end

    def self.get_discount_amount(data, i)
     data["on_sale"][i]["price"]["symbol"] + data["on_sale"][i]["price"]["discountDifference"]
    end

    def self.get
      data = self.get_data
      sale = []
      count = 0

      data["on_sale"].each do |item|
        game = Sale.new
        
        game.title = get_title(data, count)
        game.price_current = get_price_current(data, count)
        game.price_original = get_price_original(data, count)
        game.discount_percentage = get_discount_percentage(data, count)
        game.discount_amount = get_discount_amount(data, count)
        
        sale.push(game)
        count += 1
      end

      sale
    end
  end
end
