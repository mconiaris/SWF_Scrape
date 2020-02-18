class PyScraper

	def initialize
		@values = Hash.new
	end

	def process_card(card)
		raw_values = String.new
		
		File.open(card, "r") do |f|			
		  f.each_line do |line|
		    puts line
		  end  
		  f.close
		end

	end
end