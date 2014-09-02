module Gogcom
	class Func
		def self.urlfy(name)
			name = name.gsub(/[^0-9A-Za-z\s]/, '').gsub(/\s/, '_').downcase
    	name
		end
	end
end
