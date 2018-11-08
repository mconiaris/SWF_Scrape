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
	def process_card(card)
		puts 'processing card'
		
		# Create temporary containers for card info
		left = Array.new
		right = Array.new

		card.each {
			|x| if x != nil && x != "\n"

				if x.strip != nil
					left.push(x[0..35].strip)
					puts x[0..35].strip + " added to left array."
				end

				if x[36..x.size] != nil
					right.push(x[36..x.size].strip)
					puts x[36..x.size].strip + " added to right array."
				end
			end
		}
		# Create Hash for card and add vales.
		card_hash = Hash.new
		card_hash[:name] = left[0]

		# Strip out empty spaces and redundant OC & DC text
		card_hash[:OC02] = left[2][0..15].strip.split[1]
		card_hash[:OC03] = left[3][0..15].strip.split[1]

		card_hash[:OC07] = left[2][16..left.length].strip.split[1]
		card_hash[:OC08] = left[3][16..left.length].strip.split[1]
		binding.pry
		# TODO: Divide left array GC & DC lines in half
		# TODO: Convert arrays into one hash
		# TODO: Create Wrestler object
		# TODO: Add hash to Wrestler object
	end
end