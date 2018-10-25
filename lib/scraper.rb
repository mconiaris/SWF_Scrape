require 'pdf-reader'

class Scraper

	attr_accessor :reader

	# Uses pdf-reader gem to take PDFS and turns them into text.
	def initialize(card)
		@reader = PDF::Reader.new(card)
	end

	#TODO: Take reader text and do something with it.
	def capture_text
		puts @scrape.reader.page(1).text
	end
end