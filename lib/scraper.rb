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
		card_hash[:GC02] = Array.new(['GC', 2, left[2][0..15].strip.split[1]])
		card_hash[:GC03] = Array.new(['GC', 3, left[3][0..15].strip.split[1]])
		card_hash[:GC04] = Array.new(['GC', 4, left[4][0..15].strip.split[1]]) 
		card_hash[:GC05] = Array.new(['GC', 5, left[5][0..15].strip.split[1]]) 
		card_hash[:GC06] = Array.new(['GC', 6, left[6][0..15].strip.split[1]]) 
		card_hash[:GC07] = Array.new(['GC', 7, left[2][16..left.length].strip.split[1]]) 
		card_hash[:GC08] = Array.new(['GC', 8, left[3][16..left.length].strip.split[1]]) 
		card_hash[:GC09] = Array.new(['GC', 9, left[4][16..left.length].strip.split[1]]) 
		card_hash[:GC10] = Array.new(['GC', 10, left[5][16..left.length].strip.split[1]]) 
		card_hash[:GC11] = Array.new(['GC', 11, left[6][16..left.length].strip.split[1]]) 

		# Add OC12 to hash
		card_hash[:GC12] = Array.new(['GC', 12, left[7].strip.split[1]])

		# Strip DC redundant text and put values into the hash
		card_hash[:DC02] = Array.new(['DC', 2, left[9][0..15].strip.split[1]]) 
		card_hash[:DC03] = Array.new(['DC', 3, left[10][0..15].strip.split[1]]) 
		card_hash[:DC04] = Array.new(['DC', 4, left[11][0..15].strip.split[1]]) 
		card_hash[:DC05] = Array.new(['DC', 5, left[12][0..15].strip.split[1]]) 
		card_hash[:DC06] = Array.new(['DC', 6, left[13][0..15].strip.split[1]]) 
		card_hash[:DC07] = Array.new(['DC', 7, left[9][16..left.length].strip.split[1]]) 
		card_hash[:DC08] = Array.new(['DC', 8, left[10][16..left.length].strip.split[1]]) 
		card_hash[:DC09] = Array.new(['DC', 9, left[11][16..left.length].strip.split[1]]) 
		card_hash[:DC10] = Array.new(['DC', 10, left[12][16..left.length].strip.split[1]]) 
		card_hash[:DC11] = Array.new(['DC', 11, left[13][16..left.length].strip.split[1]]) 
		card_hash[:DC12] = Array.new(['DC', 12, left[14].split[1]]) 

		# Add Specialty Values to hash
		card_hash[:Specialty] = left[16]
		card_hash[:S1] = Array.new(['S', 1, left[17].split(/\d\s(.+)/)[1]]) 
		card_hash[:S2] = Array.new(['S', 2, left[18].split(/\d\s(.+)/)[1]]) 
		card_hash[:S3] = Array.new(['S', 3, left[19].split(/\d\s(.+)/)[1]]) 
		card_hash[:S4] = Array.new(['S', 4, left[20].split(/\d\s(.+)/)[1]]) 
		card_hash[:S5] = Array.new(['S', 5, left[21].split(/\d\s(.+)/)[1]]) 
		card_hash[:S6] = Array.new(['S', 6, left[22].split(/\d\s(.+)/)[1]]) 

		# Add Sub, tag and priority values to hash
		card_hash[:Sub1] = left[23].split(/SUB\s+:\s+(\d+)\s+-\s+(\d+)/)[1]
		card_hash[:Sub2] = left[23].split(/SUB\s+:\s+(\d+)\s+-\s+(\d+)/)[2]
		card_hash[:Tag1] = left[24].split(/TAG-TEAM\s+:\s+(\d+)\s+-\s+(\d+)/)[1]
		card_hash[:Tag2] = left[24].split(/TAG-TEAM\s+:\s+(\d+)\s+-\s+(\d+)/)[2]
		card_hash[:PriorityS] = left[25].split(/PRIORITY\s+:\s+(\d)\/(\d)/)[1]
		card_hash[:PriorityT] = left[25].split(/PRIORITY\s+:\s+(\d)\/(\d)/)[2]

		# Add Offensive Card to hash
		card_hash[:OC02] = Array.new(['OC', 2, right[1].split(/\d+\s+(.+)/)[1]]) 
		card_hash[:OC03] = Array.new(['OC', 3, right[2].split(/\d+\s+(.+)/)[1]]) 
		card_hash[:OC04] = Array.new(['OC', 4, right[3].split(/\d+\s+(.+)/)[1]]) 
		card_hash[:OC05] = Array.new(['OC', 5, right[4].split(/\d+\s+(.+)/)[1]]) 
		card_hash[:OC06] = Array.new(['OC', 6, right[5].split(/\d+\s+(.+)/)[1]]) 
		card_hash[:OC07] = Array.new(['OC', 7, right[6].split(/\d+\s+(.+)/)[1]]) 
		card_hash[:OC08] = Array.new(['OC', 8, right[7].split(/\d+\s+(.+)/)[1]]) 
		card_hash[:OC09] = Array.new(['OC', 9, right[8].split(/\d+\s+(.+)/)[1]]) 
		card_hash[:OC10] = Array.new(['OC', 10, right[9].split(/\d+\s+(.+)/)[1]]) 
		card_hash[:OC11] = Array.new(['OC', 11, right[10].split(/\d+\s+(.+)/)[1]]) 
		card_hash[:OC12] = Array.new(['OC', 12, right[11].split(/\d+\s+(.+)/)[1]]) 

		# Add Ropes to hash
		card_hash[:R02] = right[13].split(/\d+\s+(.+)/)[1]
		card_hash[:R03] = right[14].split(/\d+\s+(.+)/)[1]
		card_hash[:R04] = right[15].split(/\d+\s+(.+)/)[1]
		card_hash[:R05] = right[16].split(/\d+\s+(.+)/)[1]
		card_hash[:R06] = right[17].split(/\d+\s+(.+)/)[1]
		card_hash[:R07] = right[18].split(/\d+\s+(.+)/)[1]
		card_hash[:R08] = right[19].split(/\d+\s+(.+)/)[1]
		card_hash[:R09] = right[20].split(/\d+\s+(.+)/)[1]
		card_hash[:R10] = right[21].split(/\d+\s+(.+)/)[1]
		card_hash[:R11] = right[22].split(/\d+\s+(.+)/)[1]
		card_hash[:R12] = right[23].split(/\d+\s+(.+)/)[1]

		card_hash[:Set] = right[24]
		return card_hash
	end
end