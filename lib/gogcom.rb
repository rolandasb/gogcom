module Gogcom
  class << self
    # Gets game information from website.
    #
    # @param [Hash]
    #   :name => "Spelunky"
    def game(options = {})
      begin
        Gogcom::Game.new(options).get()
      rescue
        nil
      end
    end

    # Gets all items on sale.
    #
    # @param [Hash]
    #   :type => "games"
    #   :type => "movies"
    #   :limit => 5
    def sale(options = {})
      begin
        Gogcom::Sale.new(options).get()
      rescue
        nil
      end
    end

    # Gets all news
    #
    # @param [Hash]
    #   :limit => 5
    def news(options = {})
      begin
        Gogcom::News.new(options).get()
      rescue
        nil
      end
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
