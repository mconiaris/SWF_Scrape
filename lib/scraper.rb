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

		# Add card name to hash
		card_hash[:name] = left[0]

		# Strip out empty spaces and redundant OC text
		card_hash[:OC02] = left[2][0..15].strip.split[1]
		card_hash[:OC03] = left[3][0..15].strip.split[1]
		card_hash[:OC04] = left[4][0..15].strip.split[1]
		card_hash[:OC05] = left[5][0..15].strip.split[1]
		card_hash[:OC06] = left[6][0..15].strip.split[1]
		card_hash[:OC07] = left[2][16..left.length].strip.split[1]
		card_hash[:OC08] = left[3][16..left.length].strip.split[1]
		card_hash[:OC09] = left[4][16..left.length].strip.split[1]
		card_hash[:OC10] = left[5][16..left.length].strip.split[1]
		card_hash[:OC11] = left[6][16..left.length].strip.split[1]

		# Add OC12 to hash
		card_hash[:OC12] = left[7].strip.split[1]

		# Strip DC redundant text and put values into the hash
		card_hash[:DC02] = left[9][0..15].strip.split[1]
		card_hash[:DC03] = left[10][0..15].strip.split[1]
		card_hash[:DC04] = left[11][0..15].strip.split[1]
		card_hash[:DC05] = left[12][0..15].strip.split[1]
		card_hash[:DC06] = left[13][0..15].strip.split[1]
		card_hash[:DC07] = left[9][16..left.length].strip.split[1]
		card_hash[:DC08] = left[10][16..left.length].strip.split[1]
		card_hash[:DC09] = left[11][16..left.length].strip.split[1]
		card_hash[:DC10] = left[12][16..left.length].strip.split[1]
		card_hash[:DC11] = left[13][16..left.length].strip.split[1]
		card_hash[:DC12] = left[14].split[1]

		# Add Specialty Values to hash
		card_hash[:Specialty] = left[16]
		card_hash[:S1] = left[17].split(/\d\s(.+)/)[1]
		card_hash[:S2] = left[18].split(/\d\s(.+)/)[1]
		card_hash[:S3] = left[19].split(/\d\s(.+)/)[1]
		card_hash[:S4] = left[20].split(/\d\s(.+)/)[1]
		card_hash[:S5] = left[21].split(/\d\s(.+)/)[1]
		card_hash[:S6] = left[22].split(/\d\s(.+)/)[1]

		# Add Sub, tag and priority values to hash
		card_hash[:Sub1] = left[23].split(/SUB\s+:\s+(\d+)\s+-\s+(\d+)/)[1]
		card_hash[:Sub2] = left[23].split(/SUB\s+:\s+(\d+)\s+-\s+(\d+)/)[2]

		binding.pry
		# TODO: Divide left array GC & DC lines in half
		# TODO: Convert arrays into one hash
		# TODO: Create Wrestler object
		# TODO: Add hash to Wrestler object
	end
end