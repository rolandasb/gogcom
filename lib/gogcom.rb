module Gogcom
  class << self
    def game(name)
      Gogcom::Game.get(name)
    end

    def sale
    	Gogcom::Sale.get
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
