module Gogcom
  class << self
    # Gets game information from website.
    #
    # @param [string] Game name
    def game(name)
      Gogcom::Game.get(name)
    end

    # Gets all items on sale.
    #
    # @param [Hash]
    #   :type => "games"
    #   :type => "movies" 
    def sale(options = {})
    	Gogcom::Sale.get(options)
    end
  end
end

require 'net/http'
require 'json'

require 'gogcom/func'
require 'gogcom/review'
require 'gogcom/game'
require 'gogcom/sale'
require 'gogcom/version'
