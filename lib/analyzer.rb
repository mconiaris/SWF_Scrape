class Analyzer

	attr_accessor :statistics
	
	# Constants for Dice Rolls
	TWO_TWELVE = '1/36'.to_r
	THREE_ELEVEN = '2/36'.to_r
	FOUR_TEN = '3/36'.to_r
	FIVE_NINE = '4/36'.to_r
	SIX_EIGHT = '5/36'.to_r
	SEVEN = '6/36'.to_r


	def initialize
		@statistics = Hash.new
	end

	def analyze(wrestler)
		wrestler.values.each {
			|key, value| k = key.to_s
			
				if k[0..1] == 'GC'
					puts "#{key}: #{value}"
				elsif k[0..1] == 'DC'
					puts "#{key}: #{value}"
				elsif k[0] == 'S'
					puts "#{key}: #{value}"
				elsif k[0..2] == 'Sub'
					puts "#{key}: #{value}"
				elsif k[0..2] == 'Tag'
					puts "#{key}: #{value}"
				elsif k[0..2] == 'Pri'
					puts "#{key}: #{value}"
				elsif k[0..1] == 'OC'
					puts "#{key}: #{value}"
				elsif k[0] == 'R'
					puts "#{key}: #{value}"
				end
		}
	end

	def analyze_gc(roll)
	end

end