require 'pdf-reader'

class Scraper

	attr_accessor :reader

	def initialize(card)
		@reader = PDF::Reader.new(card)
	end
end