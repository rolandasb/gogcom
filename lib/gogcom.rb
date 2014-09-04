module Gogcom
  class << self
    def game(name)
      Gogcom::Game.get(name)
    end
  end
end

require 'net/http'
require 'json'

require 'gogcom/func'
require 'gogcom/review'
require 'gogcom/game'
require 'gogcom/version'
