class Analyzer

	attr_accessor :statistics
	
	# Constants for Dice Rolls
	TWO_TWELVE = '1/36'.to_r
	THREE_ELEVEN = '2/36'.to_r
	FOUR_TEN = '3/36'.to_r
	FIVE_NINE = '4/36'.to_r
	SIX_EIGHT = '5/36'.to_r
	SEVEN = '6/36'.to_r

	# Constants for DC
	DC_A = 2
	DC_B = 0
	DC_C = 4
	DC_R = 1



	def initialize
		@statistics = Hash.new
	end

	# Takes in Wrestler card information and calculates
	# the probablities and points totals.
	def analyze(wrestler)

		w = Hash.new
		dc_points = 0
		gc_oc_roll = 0
		reverse = 0
		s_points = 0
		s_pin_attempts = 0
		s_stats_array = []


		wrestler.values.each {
			|key, value| k = key.to_s
				if k[0..1] == 'GC'
					gc_oc_roll += analyze_gc(key, value)
				elsif k[0..1] == 'DC'
					# puts "#{key}: #{value}"
					dc_points += analyze_dc(key, value)
				elsif k[0] == "S" && k[1] != "p" && k[1] != 'e'
					# puts "#{key}: #{value}"
					s_stats_array.push(analyze_s(key, value))
				elsif k[0..1] == 'OC'
					puts "#{key}: #{value}"
				elsif k[0] == 'R'
					puts "#{key}: #{value}"
				else
					puts "#{key}: #{value}"
				end
		}
		w[:oc_probability] = gc_oc_roll
		w[:dc_probability] = 1 - gc_oc_roll
		w[:dc_points_per_roll] = dc_points * w[:dc_probability].to_f
		p_a = sum_of_s_array(s_stats_array)
		w[:s_pin_attempt_count] = p_a[:s_pin_attempt_count]
		w[:s_points] = p_a[:s_points]
		w[:sub_probability] = sub_tag_probability(wrestler.values[:Sub1], wrestler.values[:Sub2])
		w[:tag_probability] = sub_tag_probability(wrestler.values[:Tag1], wrestler.values[:Tag2])
		w[:singles_priority] = wrestler.values[:PriorityS]
		w[:tag_priority] = wrestler.values[:PriorityT]
		# binding.pry
		return w
	end

	def analyze_gc(k, v)
		if v.include?('OC')
			case k
			when :GC02
				return TWO_TWELVE
			when :GC03
				return THREE_ELEVEN
			when :GC04
				return FOUR_TEN
			when :GC05
				return FIVE_NINE
			when :GC06
				return SIX_EIGHT
			when :GC07
				return SEVEN
			when :GC08
				return SIX_EIGHT
			when :GC09
				return FIVE_NINE
			when :GC10
				return FOUR_TEN
			when :GC11
				return THREE_ELEVEN
			when :GC12
				return TWO_TWELVE
			else
				return 0
			end
		else
			return 0
		end
	end

	
	def analyze_dc(k, v)
		case k
		when :DC02
			return dc_point_roll(TWO_TWELVE, v)
		when :DC03
			dc_point_roll(THREE_ELEVEN, v)
		when :DC04
			return dc_point_roll(FOUR_TEN, v)
		when :DC05
			return dc_point_roll(FIVE_NINE, v)
		when :DC06
			return dc_point_roll(SIX_EIGHT, v)
		when :DC07
			return dc_point_roll(SEVEN, v)
		when :DC08
			return dc_point_roll(SIX_EIGHT, v)
		when :DC09
			return dc_point_roll(FIVE_NINE, v)
		when :DC10
			return dc_point_roll(FOUR_TEN, v)
		when :DC11
			return dc_point_roll(THREE_ELEVEN, v)
		when :DC12
			return dc_point_roll(TWO_TWELVE, v)
		else
			return 0
		end
	else
		return 0
	end


	# For Specialty math
	def analyze_s(k, v)
		v.split
	end


	# For Specialty math
	def sum_of_s_array(s_array)

		# TODO: Figure out DQ rolls in S.
		# Calculate number of points
		b = s_array.map {
			|x| x[0].to_i
		}

		# Count number of P/A or sub attempts
		a = s_array.map { 
			|x| x[1] 
		}
		a.delete_if { 
			|x| x == nil 
		}
		s_stats = Hash.new
		s_stats[:s_pin_attempt_count] = a.size
		s_stats[:s_points] = b.sum
		return s_stats
	end


	# For DC Math
	def dc_point_roll(roll, result)
		if result == 'A'
			# puts result
			DC_A * roll
		elsif result == 'B'
			# puts result
			return 0
		elsif result == 'C'
			# puts result
			DC_C * roll
		elsif result == "REVERSE"
			# puts result
			DC_R * roll
		end
	end

	# Takes SUB or TAG values and calculates probability 
	# a card rolling that range.
	def sub_tag_probability(a, b)
		num_range = 0
		s = Range.new(a.to_i, b.to_i)
		
		s.each { |x|
			if x == 2
				num_range += TWO_TWELVE
			elsif x == 3
				num_range += THREE_ELEVEN
			elsif x == 4
				num_range += FOUR_TEN
			elsif x == 5
				num_range += FIVE_NINE
			elsif x == 6
				num_range += SIX_EIGHT
			elsif x == 7
				num_range += SEVEN
			elsif x == 8
				num_range += SIX_EIGHT
			elsif x == 9
				num_range += FIVE_NINE
			elsif x == 10
				num_range += FOUR_TEN
			elsif x == 11
				num_range += THREE_ELEVEN
			elsif x == 12
				num_range += TWO_TWELVE
			else
				puts "Incorrect number."
			end
		}
			return num_range	

	end


end