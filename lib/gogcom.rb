module Gogcom
	class << self
		def game(name)
			Gogcom::Game.get(name)
		end
	end
end

require 'open-uri'
require 'nokogiri'
require 'json'

require 'gogcom/func'
require 'gogcom/review'
require 'gogcom/game'
require 'gogcom/version'
