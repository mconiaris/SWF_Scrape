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

	# Takes in Wrestler card information and calculates
	# the probablities and points totals.
	def analyze(wrestler)

		w = Hash.new
		gc_oc_roll = 0

		wrestler.values.each {
			|key, value| k = key.to_s
			
				if k[0..1] == 'GC'
					gc_oc_roll += analyze_gc(key, value)
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
		w[:oc_probability] = gc_oc_roll
		w[:dc_probability] = 1 - gc_oc_roll
		return w
	end

	def analyze_gc(k, v)
		if v.include?('OC')
			case k
			when :GC02
				puts "#{TWO_TWELVE} added."
				return TWO_TWELVE
			when :GC03
				puts "#{THREE_ELEVEN} added"
				return THREE_ELEVEN
			when :GC04
				puts "#{FOUR_TEN} added."
				return FOUR_TEN
			when :GC05
				puts "#{FIVE_NINE} added"
				return FIVE_NINE
			when :GC06
				puts "#{SIX_EIGHT} added"
				return SIX_EIGHT
			when :GC07
				puts "#{SEVEN} added"
				return SEVEN
			when :GC08
				puts "#{SIX_EIGHT} added."
				return SIX_EIGHT
			when :GC09
				puts "#{FIVE_NINE} added."
				return FIVE_NINE
			when :GC10
				puts "#{FOUR_TEN} added."
				return FOUR_TEN
			when :GC11
				puts "#{THREE_ELEVEN} added."
				return THREE_ELEVEN
			when :GC12
				puts "#{TWO_TWELVE} added."
				return TWO_TWELVE
			else
				return 0
			end
		else
			puts "DC, nothing added."
			return 0
		end
	end

end