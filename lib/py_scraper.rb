class PyScraper

	def initialize
		@values = Hash.new
	end

	def scrape_card(card)
		raw_values = String.new
		
		File.open(card, "r") do |f|			
		  f.each_line do |line|
		  	if !line.start_with?("#")
		    	raw_values << line
		    end
		  end  
		  f.close
		end

		return raw_values
	end

	def process_card(card)
		# Create Hash for card and add vales.
		card_hash = Hash.new

		# Add card name to hash
		x = card.lines.select { |x| x.downcase.include?("name =") }
		card_hash[:name] = x[0].chomp.split(/name = .(.+)'/).last
		# Strip out empty spaces and redundant OC text

		# Isolate General Card Rolls
		x = card.lines.select { |x| x.include?("GeneralCard = ") }
		gc_array = x[0].chomp.split(",")
		gc_array[0] = gc_array[0].split(/GeneralCard = \[(100\d)/).last
		gc_array[10] = gc_array[10].chop

		# Replace codes with OC || OC/TT || DC
		# General Card Definitions: 
		# 1000 = OC
		# 1001 = OC/TT
		# 1002 = DC
		k = 2
		gc_array.each { |x|
			key = "%02d" % [k]
			key = ("GC" + key).to_sym
			k += 1

			if x.strip == "1000"
				y = "OC"
			elsif x.strip == "1001"
				y = "OC/TT"
			elsif x.strip == "1002"
				y = "DC"
			else
				y = "Error"
			end
			
			card_hash[key] = y

		}


		# Strip DC redundant text and put values into the hash
		card_hash[:DC02] = 
		card_hash[:DC03] = 
		card_hash[:DC04] = 
		card_hash[:DC05] = 
		card_hash[:DC06] = 
		card_hash[:DC07] = 
		card_hash[:DC08] = 
		card_hash[:DC09] = 
		card_hash[:DC10] = 
		card_hash[:DC11] = 
		card_hash[:DC12] = 

		# Add Specialty Values to hash
		card_hash[:Specialty] = 
		card_hash[:S1] = 
		card_hash[:S2] = 
		card_hash[:S3] = 
		card_hash[:S4] = 
		card_hash[:S5] = 
		card_hash[:S6] = 

		# Add Sub, tag and priority values to hash
		# TODO: Fix case when SUB only has one value
		# TODO: Fix case when TT only has one value
		card_hash[:Sub] = 
		card_hash[:Tag] = 
		singles_priority = 
		tag_team_priority = 

		card_hash[:PriorityS] = 
		card_hash[:PriorityT] = 

		# Add Offensive Card to hash
		card_hash[:OC02] = 
		card_hash[:OC03] = 
		card_hash[:OC04] = 
		card_hash[:OC05] = 
		card_hash[:OC06] = 
		card_hash[:OC07] = 
		card_hash[:OC08] = 
		card_hash[:OC09] = 
		card_hash[:OC10] = 
		card_hash[:OC11] = 
		card_hash[:OC12] = 

		# Add Ropes to hash
		card_hash[:RO02] = 
		card_hash[:RO03] = 
		card_hash[:RO04] = 
		card_hash[:RO05] = 
		card_hash[:RO06] = 
		card_hash[:RO07] = 
		card_hash[:RO08] = 
		card_hash[:RO09] = 
		card_hash[:RO10] = 
		card_hash[:RO11] = 
		card_hash[:RO12] = 

		if right[24] != nil
			if card_hash[:Set].class == Array
				card_hash[:Set] = right[24][0]
			else
				card_hash[:Set] = right[24]
			end
		end
	end
end