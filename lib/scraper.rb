
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

		card_hash[:gc02] = left[2][0..15].strip.split[1]
		card_hash[:gc03] = left[3][0..15].strip.split[1]
		card_hash[:gc04] = left[4][0..15].strip.split[1] 
		card_hash[:gc05] = left[5][0..15].strip.split[1] 
		card_hash[:gc06] = left[6][0..15].strip.split[1] 
		card_hash[:gc07] = left[2][16..left[2].length].strip.split[1]
		card_hash[:gc08] = left[3][16..left[3].length].strip.split[1]
		card_hash[:gc09] = left[4][16..left[4].length].strip.split[1]
		card_hash[:gc10] = left[5][16..left[5].length].strip.split[1]
		card_hash[:gc11] = left[6][16..left[6].length].strip.split[1]
		# Add OC12 to hash
		card_hash[:gc12] = left[7].strip.split[1]

		# Strip DC redundant text and put values into the hash
		card_hash[:dc02] = left[9][0..15].strip.split[1]
		card_hash[:dc03] = left[10][0..15].strip.split[1]
		card_hash[:dc04] = left[11][0..15].strip.split[1]
		card_hash[:dc05] = left[12][0..15].strip.split[1]
		card_hash[:dc06] = left[13][0..15].strip.split[1]
		card_hash[:dc07] = left[9][16..left[9].length].strip.split[1]
		card_hash[:dc08] = left[10][16..left[10].length].strip.split[1]
		card_hash[:dc09] = left[11][16..left[11].length].strip.split[1]
		card_hash[:dc10] = left[12][16..left[12].length].strip.split[1]
		card_hash[:dc11] = left[13][16..left[13].length].strip.split[1]
		card_hash[:dc12] = left[14].split[1]

		# Add Specialty Values to hash
		card_hash[:specialty] = move_formatter(left[16])
		card_hash[:s1] = left[17].split(/\d\s(.+)/)[1]
		card_hash[:s2] = left[18].split(/\d\s(.+)/)[1]
		card_hash[:s3] = left[19].split(/\d\s(.+)/)[1]
		card_hash[:s4] = left[20].split(/\d\s(.+)/)[1]
		card_hash[:s5] = left[21].split(/\d\s(.+)/)[1]
		card_hash[:s6] = left[22].split(/\d\s(.+)/)[1]

		# Add Sub, tag and priority values to hash
		# TODO: Fix case when SUB only has one value
		# TODO: Fix case when TT only has one value

		card_hash[:sub] = scrape_sub_and_tag(left[23])
		card_hash[:tag] = scrape_sub_and_tag(left[24])
		singles_priority = scrape_priority(left[25])[0]
		tag_team_priority = scrape_priority(left[25])[1]

		card_hash[:prioritys] = calculate_singles_priority(singles_priority)
		card_hash[:priorityt] = calculate_tag_team_priority(tag_team_priority)

		# Add Offensive Card to hash
		card_hash[:oc02] = right[1].split(/\d+\s+(.+)/)[1]
		card_hash[:oc03] = right[2].split(/\d+\s+(.+)/)[1]
		card_hash[:oc04] = right[3].split(/\d+\s+(.+)/)[1]
		card_hash[:oc05] = right[4].split(/\d+\s+(.+)/)[1]
		card_hash[:oc06] = right[5].split(/\d+\s+(.+)/)[1]
		card_hash[:oc07] = right[6].split(/\d+\s+(.+)/)[1]
		card_hash[:oc08] = right[7].split(/\d+\s+(.+)/)[1]
		card_hash[:oc09] = right[8].split(/\d+\s+(.+)/)[1]
		card_hash[:oc10] = right[9].split(/\d+\s+(.+)/)[1]
		card_hash[:oc11] = right[10].split(/\d+\s+(.+)/)[1]
		card_hash[:oc12] = right[11].split(/\d+\s+(.+)/)[1]

		# Add Ropes to hash
		card_hash[:ro02] = right[13].split(/\d+\s+(.+)/)[1]
		card_hash[:ro03] = right[14].split(/\d+\s+(.+)/)[1]
		card_hash[:ro04] = right[15].split(/\d+\s+(.+)/)[1]
		card_hash[:ro05] = right[16].split(/\d+\s+(.+)/)[1]
		card_hash[:ro06] = right[17].split(/\d+\s+(.+)/)[1]
		card_hash[:ro07] = right[18].split(/\d+\s+(.+)/)[1]
		card_hash[:ro08] = right[19].split(/\d+\s+(.+)/)[1]
		card_hash[:ro09] = right[20].split(/\d+\s+(.+)/)[1]
		card_hash[:ro10] = right[21].split(/\d+\s+(.+)/)[1]
		card_hash[:ro11] = right[22].split(/\d+\s+(.+)/)[1]
		card_hash[:ro12] = right[23].split(/\d+\s+(.+)/)[1]

		if right[24] != nil
			if card_hash[:set].class == Array
				card_hash[:set] = right[24][0]
			else
				card_hash[:set] = right[24]
			end
		end

		# If Wrestler moves are in all caps, format it for consistency.
		card_hash.each { |k,v| 
			if k.to_s.include?('oc') || k.to_s.include?('oc') || v.include?('reverse')
				card_hash[k] = move_formatter(v)
			end
		}

		# Make sure that DQ text is uppercase
		h = card_hash.select { |k,v| v.include?('(dq)') }
		h.each { |k,v| 
			card_hash[k] = v.sub('dq', 'DQ')
		}

		# Make sure that P/A text is uppercase
		h = card_hash.select { |k,v| v.include?('P/a') }
		h.each { |k,v| 
			card_hash[k] = v.sub('P/a', 'P/A')
		}

		# Make sure that (S) text is uppercase
		h = card_hash.select { |k,v| v.include?('(s)') }
		h.each { |k,v| 
			card_hash[k] = v.sub('(s)', '(S)')
		}

		# Make sure that N/A text is uppercase
		h = card_hash.select { |k,v| k.to_s.include?('ro') }
		h.select { |k,v| v.include?('Na') }
		h.each { |k,v| 
			card_hash[k] = v.sub('Na', 'N/A')
		}

		# Fix formatting for * attempts
		h = card_hash.select { |k,v| v.include?(' *') }
		h.each { |k,v| 
			card_hash[k] = v.sub(' *', '*')
		}

		puts "Analyzing #{card_hash[:name]} of #{card_hash[:set]}"
		return card_hash
	end


	# Takes the text and converts it to a wrestler object.
	def process_converted_card(card)
		puts 'processing card'
		# Create temporary containers for card info
		left = Array.new
		right = Array.new

		card.each {
			|x| if x != nil && x != "\n"

				if x.strip != nil
					left.push(x[0..30].strip)
					# puts x[0..35].strip + " added to left array."
				end

				if x[31..x.size] != nil
					right.push(x[31..x.size].strip)
					# puts x[36..x.size].strip + " added to right array."
				end
			end
		}

		# Create Hash for card and add vales.
		card_hash = Hash.new

		# Add card name to hash
		card_hash[:name] = card[0][0..35].strip
		# Strip out empty spaces and redundant OC text
		card_hash[:gc02] = left[1][0..14].strip.split[1]
		card_hash[:gc03] = left[2][0..14].strip.split[1]
		card_hash[:gc04] = left[3][0..14].strip.split[1]
		card_hash[:gc05] = left[4][0..14].strip.split[1] 
		card_hash[:gc06] = left[5][0..14].strip.split[1] 

		card_hash[:gc07] = left[1][15..left[1].length].strip.split[1]
		card_hash[:gc08] = left[2][15..left[2].length].strip.split[1]
		card_hash[:gc09] = left[3][15..left[3].length].strip.split[1]
		card_hash[:gc10] = left[4][15..left[4].length].strip.split[1]
		card_hash[:gc11] = left[5][15..left[5].length].strip.split[1]

		# Add OC12 to hash
		card_hash[:gc12] = left[6].split('12')[1].strip

		# Strip DC redundant text and put values into the hash
		card_hash[:dc02] = left[7][0..14].strip.split[1]
		card_hash[:dc02] = left[8][0..14].strip.split[1]
		card_hash[:dc03] = left[9][0..14].strip.split[1]
		card_hash[:dc04] = left[10][0..14].strip.split[1]
		card_hash[:dc05] = left[11][0..14].strip.split[1]
		card_hash[:dc06] = left[12][0..14].strip.split[1]
		card_hash[:dc07] = left[8][15..left[8].length].strip.split[1]
		card_hash[:dc08] = left[9][15..left[9].length].strip.split[1]
		card_hash[:dc09] = left[10][15..left[10].length].strip.split[1]
		card_hash[:dc10] = left[11][15..left[11].length].strip.split[1]
		card_hash[:dc11] = left[12][15..left[12].length].strip.split[1]
		card_hash[:dc12] = left[13].split('12')[1]

		# Add Specialty Values to hash
		card_hash[:specialty] = left[15]
		card_hash[:s1] = left[16].split(/\d\s(.+)/)[1]
		card_hash[:s2] = left[17].split(/\d\s(.+)/)[1]
		card_hash[:s3] = left[18].split(/\d\s(.+)/)[1]
		card_hash[:s4] = left[19].split(/\d\s(.+)/)[1]
		card_hash[:s5] = left[20].split(/\d\s(.+)/)[1]
		card_hash[:s6] = left[21].split(/\d\s(.+)/)[1]

		# Add Sub, tag and priority values to hash
		# Factor out into method to DRY
		x = left[22].split
		subm = x[1].split('-')
		card_hash[:sub] = subm

		y = left[23].split
		tag = y[1].split('-')
		card_hash[:tag] = tag


		# TODO: Factor out into method
		# Determine Singles and Tag Team Priorities
		z = left[24].split.last
		pri = z.split('/')
		singles_priority = pri[0]
		tag_team_priority = pri[1]

		card_hash[:prioritys] = calculate_singles_priority(singles_priority)
		card_hash[:priorityt] = calculate_tag_team_priority(tag_team_priority)


		# Add Offensive Card to hash
		card_hash[:oc02] = right[1].split(/\d+\s+(.+)/)[1]		
		card_hash[:oc03] = right[2].split(/\d+\s+(.+)/)[1]
		card_hash[:oc04] = right[3].split(/\d+\s+(.+)/)[1]
		card_hash[:oc05] = right[4].split(/\d+\s+(.+)/)[1]
		card_hash[:oc06] = right[5].split(/\d+\s+(.+)/)[1]
		card_hash[:oc07] = right[6].split(/\d+\s+(.+)/)[1]
		card_hash[:oc08] = right[7].split(/\d+\s+(.+)/)[1]
		card_hash[:oc09] = right[8].split(/\d+\s+(.+)/)[1]
		card_hash[:oc10] = right[9].split(/\d+\s+(.+)/)[1]
		card_hash[:oc11] = right[10].split(/\d+\s+(.+)/)[1]
		card_hash[:oc12] = right[11].split(/\d+\s+(.+)/)[1]

		# Add Ropes to hash
		card_hash[:ro02] = right[13].split(/\d+\s+(.+)/)[1]
		card_hash[:ro03] = right[14].split(/\d+\s+(.+)/)[1]
		card_hash[:ro04] = right[15].split(/\d+\s+(.+)/)[1]
		card_hash[:ro05] = right[16].split(/\d+\s+(.+)/)[1]
		card_hash[:ro06] = right[17].split(/\d+\s+(.+)/)[1]
		card_hash[:ro07] = right[18].split(/\d+\s+(.+)/)[1]
		card_hash[:ro08] = right[19].split(/\d+\s+(.+)/)[1]
		card_hash[:ro09] = right[20].split(/\d+\s+(.+)/)[1]
		card_hash[:ro10] = right[21].split(/\d+\s+(.+)/)[1]
		card_hash[:ro11] = right[22].split(/\d+\s+(.+)/)[1]
		card_hash[:ro12] = right[23].split(/\d+\s+(.+)/)[1]



		if right[24] != nil
			if card_hash[:set].class == Array
				card_hash[:set] = right[24][0]
			else
				card_hash[:set] = right[24]
			end
		end
		
		if card_hash[:set] == nil
			card_hash[:set] = "Special"
		end

		# Fix Issues with Reverse in Converted Scans
		# Find DC keys with values of R and replace
		# them with REVERSE values.
		dc_hash = card_hash.select { |k,v| 
			key = k.to_s
			key.include?("dc")
		}
		keys = dc_hash.select { |k,v|
			v[0] == "R"
		}

		puts "Analyzing #{card_hash[:name]} of my Special set"
		return card_hash
	end




	private

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


	def move_formatter(move)
		a = move.split
		a.each { |x| x.capitalize! }
		a.join(' ')
	end	
	
end