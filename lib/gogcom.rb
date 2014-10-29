module Gogcom
  class << self
    # Gets game information from website.
    #
    # @param [string] Game name
    def game(options)
      Gogcom::Game.new(options).get()
    end

    # Gets all items on sale.
    #
    # @param [Hash]
    #   :type => "games"
    #   :type => "movies"
    #   :limit => 5
    def sale(options = {})
        Gogcom::Sale.new(options).get()
    end

    # Gets all news
    #
    # @param [Hash]
    #   :limit => 5
    def news(options = {})
      Gogcom::News.new(options).get()
    end
  end
end

require 'net/http'
require 'json'
require 'simple-rss'

require 'gogcom/game'
require 'gogcom/sale'
require 'gogcom/news'
require 'gogcom/version'
