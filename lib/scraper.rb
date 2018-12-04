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
binding.pry
		# Create temporary containers for card info
		left = Array.new
		right = Array.new

		card.each {
			|x| if x != nil && x != "\n"

				if x.strip != nil
					left.push(x[0..35].strip)
					# puts x[0..35].strip + " added to left array."
				end

				if x[36..x.size] != nil
					right.push(x[36..x.size].strip)
					# puts x[36..x.size].strip + " added to right array."
				end
			end
		}
		# Create Hash for card and add vales.
		card_hash = Hash.new

		# Add card name to hash
		card_hash[:name] = left[0]
		# Strip out empty spaces and redundant OC text
		card_hash[:GC02] = left[2][0..15].strip.split[1]
		card_hash[:GC03] = left[3][0..15].strip.split[1]
		card_hash[:GC04] = left[4][0..15].strip.split[1] 
		card_hash[:GC05] = left[5][0..15].strip.split[1] 
		card_hash[:GC06] = left[6][0..15].strip.split[1] 
		card_hash[:GC07] = left[2][16..left[2].length].strip.split[1]
		card_hash[:GC08] = left[3][16..left[3].length].strip.split[1]
		card_hash[:GC09] = left[4][16..left[4].length].strip.split[1]
		card_hash[:GC10] = left[5][16..left[5].length].strip.split[1]
		card_hash[:GC11] = left[6][16..left[6].length].strip.split[1]

		# Add OC12 to hash
		card_hash[:GC12] = left[7].strip.split[1]

		# Strip DC redundant text and put values into the hash
		card_hash[:DC02] = left[9][0..15].strip.split[1]
		card_hash[:DC03] = left[10][0..15].strip.split[1]
		card_hash[:DC04] = left[11][0..15].strip.split[1]
		card_hash[:DC05] = left[12][0..15].strip.split[1]
		card_hash[:DC06] = left[13][0..15].strip.split[1]
		card_hash[:DC07] = left[9][16..left[9].length].strip.split[1]
		card_hash[:DC08] = left[10][16..left[10].length].strip.split[1]
		card_hash[:DC09] = left[11][16..left[11].length].strip.split[1]
		card_hash[:DC10] = left[12][16..left[12].length].strip.split[1]
		card_hash[:DC11] = left[13][16..left[13].length].strip.split[1]
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
		# TODO: Fix case when SUB only has one value
		# TODO: Fix case when TT only has one value
		card_hash[:Sub] = scrape_sub_and_tag(left[23])
		card_hash[:Tag] = scrape_sub_and_tag(left[24])
		singles_priority = scrape_priority(left[25])[0]
		tag_team_priority = scrape_priority(left[25])[1]

		card_hash[:PriorityS] = calculate_singles_priority(singles_priority)
		card_hash[:PriorityT] = calculate_tag_team_priority(tag_team_priority)

		# Add Offensive Card to hash
		card_hash[:OC02] = right[1].split(/\d+\s+(.+)/)[1]
		card_hash[:OC03] = right[2].split(/\d+\s+(.+)/)[1]
		card_hash[:OC04] = right[3].split(/\d+\s+(.+)/)[1]
		card_hash[:OC05] = right[4].split(/\d+\s+(.+)/)[1]
		card_hash[:OC06] = right[5].split(/\d+\s+(.+)/)[1]
		card_hash[:OC07] = right[6].split(/\d+\s+(.+)/)[1]
		card_hash[:OC08] = right[7].split(/\d+\s+(.+)/)[1]
		card_hash[:OC09] = right[8].split(/\d+\s+(.+)/)[1]
		card_hash[:OC10] = right[9].split(/\d+\s+(.+)/)[1]
		card_hash[:OC11] = right[10].split(/\d+\s+(.+)/)[1]
		card_hash[:OC12] = right[11].split(/\d+\s+(.+)/)[1]

		# Add Ropes to hash
		card_hash[:RO02] = right[13].split(/\d+\s+(.+)/)[1]
		card_hash[:RO03] = right[14].split(/\d+\s+(.+)/)[1]
		card_hash[:RO04] = right[15].split(/\d+\s+(.+)/)[1]
		card_hash[:RO05] = right[16].split(/\d+\s+(.+)/)[1]
		card_hash[:RO06] = right[17].split(/\d+\s+(.+)/)[1]
		card_hash[:RO07] = right[18].split(/\d+\s+(.+)/)[1]
		card_hash[:RO08] = right[19].split(/\d+\s+(.+)/)[1]
		card_hash[:RO09] = right[20].split(/\d+\s+(.+)/)[1]
		card_hash[:RO10] = right[21].split(/\d+\s+(.+)/)[1]
		card_hash[:RO11] = right[22].split(/\d+\s+(.+)/)[1]
		card_hash[:RO12] = right[23].split(/\d+\s+(.+)/)[1]

		if right[24] != nil
			card_hash[:Set] = right[24]
		end

		puts "Analyzing #{card_hash[:name]} of #{card_hash[:Set]}"
		return card_hash
	end

	def scrape_sub_and_tag(value)
		v = value.split
		v.delete_at(0)
		v.delete_at(0)
		if v.size > 1
			v.delete_at(1)
		end
		return v
	end

	# Take in Priority text and split it twice to 
	# isolate the characters needed.
	def scrape_priority(value)
		x = value.split
		v = x[2].split('/')
		return v
	end


	def calculate_singles_priority(priority)
		if priority == '5+'
			return '6'
		else
			return priority.to_i.to_s
		end
	end


	def calculate_tag_team_priority(priority)
		if priority == '3+'
			return '4'
		else
			return priority.to_i.to_s
		end
	end
end