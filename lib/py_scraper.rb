class PyScraper

	def initialize
		@values = Hash.new
	end

	def scrape_card(card)
		raw_values = String.new
		
		File.open(card, "r") do |f|			
		  f.each_line do |line|
		    raw_values << line
		  end  
		  f.close
		  return raw_values
		end
	end

	def process_card(card)

	end
end