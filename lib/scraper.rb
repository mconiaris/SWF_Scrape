require 'pdf-reader'

class Scraper

	attr_accessor :card
	attr_accessor :reader

	# Uses pdf-reader gem to take PDFS and turns them into text.
	def initialize(card)
		@reader = PDF::Reader.new(card)
		@card = reader.page(1).text.lines
	end

	# Takes the text and converts it to a wrestler object.
	def process_card
	end
end