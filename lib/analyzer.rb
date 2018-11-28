class Analyzer

	# TODO: Use SWF_Card_Analyzer Math to do final
	# card analysis.

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
		gc_oc_roll_probability = 0
		gc_dc_roll_probability = 0

		dc_reverse_roll_probability = 0
		
		dc_points = 0
		oc_pa_probability = 0
		oc_points = 0
		oc_points_array = []
		reverse = 0
		ropes_points = 0
		ropes_points_array = []
		s_points = 0
		s_pin_attempts = 0
		s_stats_array = []
		xx_probability = 0

		wrestler.values.each {
			|key, value| k = key.to_s
				if k[0..1] == 'GC'
					puts "#{key}: #{value}"
					gc_oc_roll_probability += calculate_gc_oc_roll_probability(key, value)
				elsif k[0..1] == 'DC'
					puts "#{key}: #{value}"
					# dc_points += analyze_dc(key, value)
				elsif k[0] == "S" && k[1] != "p" && k[1] != 'e'
					puts "#{key}: #{value}"
					# s_stats_array.push(analyze_s(key, value))
				elsif k[0..1] == 'OC'
					puts "#{key}: #{value}"
					puts "\n"
					# oc_points_array << create_oc_ropes_moves_array(key, value)
				elsif k[0] == 'R'
					puts "#{key}: #{value}"
					# ropes_points_array << create_oc_ropes_moves_array(key, value)
				else
					puts "#{key}: #{value}"
				end
		}

		# Calculate temporary Variables
		gc_dc_roll_probability = calculate_gc_dc_roll_probability(gc_oc_roll_probability)
		dc_reverse_roll_probability = calculate_reverse_roll_probability(wrestler.values, gc_dc_roll_probability)


		# Add values to wrestler's hash
		w[:oc_probability] = gc_oc_roll_probability
		w[:dc_probability] = gc_dc_roll_probability
		w[:tt_probability] = calculate_gc_tt_roll_probability(wrestler.values)

		

# 		# Calculate OC points
# 		oc_points = calculate_oc_ropes_points(oc_points_array, gc_oc_roll)
# 		oc_prob_hash = calculate_pa_ropes_sub_xx_dq(oc_points_array, gc_oc_roll)
# 		# Multiply ropes values by oc_ropes_probability
# 		# This is to calculate a X-per-roll.
# 		oc_ropes_probability = oc_prob_hash[:ropes]
# 		ropes_points = calculate_oc_ropes_points(ropes_points_array)
# 		ropes_points = ropes_points * oc_ropes_probability
# 		ropes_prob_hash = calculate_pa_ropes_sub_xx_dq(ropes_points_array)
# 		w[:dc_points_per_roll] = dc_points * w[:dc_probability].to_f
# 		p_a = sum_of_s_array(s_stats_array)
# 		w[:s_pin_attempt_count] = p_a[:s_pin_attempt_count]
# 		w[:s_points] = p_a[:s_points]
# 		w[:sub_probability] = sub_tag_probability(wrestler.values[:Sub1], wrestler.values[:Sub2])
# 		w[:tag_probability] = sub_tag_probability(wrestler.values[:Tag1], wrestler.values[:Tag2])
# 		w[:singles_priority] = wrestler.values[:PriorityS]
# 		w[:tag_priority] = wrestler.values[:PriorityT]

# binding.pry
		return w
	end


	# This returns the rational number (fraction) of a
	# 2d6 roll so that it can be used to calculate the
	# probabilty of rolls for GC, OC & DC.
	def calculate_probability(key)
		k = key[2..3]

		case k
		when '02'
			return TWO_TWELVE
		when '03'
			return THREE_ELEVEN
		when '04'
			return FOUR_TEN
		when '05'
			return FIVE_NINE
		when '06'
			return SIX_EIGHT
		when '07'
			return SEVEN
		when '08'
			return SIX_EIGHT
		when '09'
			return FIVE_NINE
		when '10'
			return FOUR_TEN
		when '11'
			return THREE_ELEVEN
		when '12'
			return TWO_TWELVE
		else
			return 0
		end
	else
		return 0
	end
	

	# ============
	# GENERAL CARD
	# ============

	# Takes in wrestler hash and calculates the
	# probability of an OC roll.
	def calculate_gc_oc_roll_probability(key, value)
		oc_roll_probability = 0

		# Converts symbol key into a string so it can be 
		# passed to the calculate_probabily method.
		k = key.to_s

		if value.include?('OC')
			oc_roll_probability += calculate_probability(k)
		else return 0
		end
	end

	# Takes in probability of an OC roll and uses it to
	# determine the probability of a DC roll.
	def calculate_gc_dc_roll_probability(oc_roll_probability)
		return 36/36.to_r - oc_roll_probability
	end


	# Takes in wrestler card hash and searches for OC/TT
	# rolls and then calculates their probability.
	def calculate_gc_tt_roll_probability(wrestler_hash)
		h = wrestler_hash.select { |k,v| v == 'OC/TT' }
		prob = 0

		h.each_key {
			|k| prob += calculate_probability(k)
		}
		return prob
	end


	# ==============
	# DEFENSIVE CARD
	# ==============
	# Takes in wrestler card hash and searches for OC/TT
	# rolls and then calculates their probability.
	def calculate_reverse_roll_probability(wrestler_hash, gc_dc_roll_probability)
		h = wrestler_hash.select { |k,v| v == 'REVERSE' }
		prob = 0

		h.each_key {
			|k| prob += calculate_probability(k)
		}
		return prob * gc_dc_roll_probability
	end










	
	# def analyze_dc(k, v)
	# 	case k
	# 	when :DC02
	# 		return dc_point_roll(TWO_TWELVE, v)
	# 	when :DC03
	# 		dc_point_roll(THREE_ELEVEN, v)
	# 	when :DC04
	# 		return dc_point_roll(FOUR_TEN, v)
	# 	when :DC05
	# 		return dc_point_roll(FIVE_NINE, v)
	# 	when :DC06
	# 		return dc_point_roll(SIX_EIGHT, v)
	# 	when :DC07
	# 		return dc_point_roll(SEVEN, v)
	# 	when :DC08
	# 		return dc_point_roll(SIX_EIGHT, v)
	# 	when :DC09
	# 		return dc_point_roll(FIVE_NINE, v)
	# 	when :DC10
	# 		return dc_point_roll(FOUR_TEN, v)
	# 	when :DC11
	# 		return dc_point_roll(THREE_ELEVEN, v)
	# 	when :DC12
	# 		return dc_point_roll(TWO_TWELVE, v)
	# 	else
	# 		return 0
	# 	end
	# else
	# 	return 0
	# end


# 	# For Specialty math
# 	def analyze_s(k, v)
# 		v.split
# binding.pry
# 	end


	# # For Specialty math
	# def sum_of_s_array(s_array)

	# 	# TODO: Figure out DQ rolls in S.
	# 	# Calculate number of points
	# 	b = s_array.map {
	# 		|x| x[0].to_i
	# 	}

	# 	# Count number of P/A or sub attempts
	# 	a = s_array.map { 
	# 		|x| x[1] 
	# 	}
	# 	a.delete_if { 
	# 		|x| x == nil 
	# 	}
	# 	s_stats = Hash.new
	# 	s_stats[:s_pin_attempt_count] = a.size
	# 	s_stats[:s_points] = b.sum
	# 	return s_stats
	# end


	# # For DC Math
	# def dc_point_roll(roll, result)
	# 	if result == 'A'
	# 		# puts result
	# 		DC_A * roll
	# 	elsif result == 'B'
	# 		# puts result
	# 		return 0
	# 	elsif result == 'C'
	# 		# puts result
	# 		DC_C * roll
	# 	elsif result == "REVERSE"
	# 		# puts result
	# 		DC_R * roll
	# 	end
	# end

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


	# # Takes move string, splits it, and then adds
	# # points, XX, *, P/A, DQ and probability into 
	# # an array for analysis.
	# def create_oc_ropes_moves_array(key, move)
	# 	m = move.split
	# 	puts m

	# 	if (m.last != '*') && (m.last != '(XX)') && m.last != ('P/A') && m.last != ('(DQ)')
	# 		x = [calculate_probability(key), m.last]
	# 	elsif m.last == '(S)'
	# 		x = [calculate_probability(key), m.last]
	# 	elsif move == 'ROPES'
	# 		x = [calculate_probability(key), move]
	# 	else
	# 		x = [calculate_probability(key), m[-2], m[-1]]
	# 	end	
	# end

	# # Takes in 2d6/36 value of a roll on an OC card and
	# # the string value of the points total. It converts
	# # the String to a float and multiplies the value.
	# # It then multiplies that number by the probability
	# # that OC will be rolled in the General Card.
	# # This returns a points per roll float starting from
	# # the beginning of a round.
	# def calculate_oc_ropes_points(array, gc_oc_roll)
	# 	p = 0

	# 	array.each { |x|
	# 		p += (x[0].to_f * x[1].to_f)
	# 	}
	# 	points = p * gc_oc_roll

	# 	return points
	# end


	# def calculate_pa_ropes_sub_xx_dq(array, gc_oc_roll)
	# 	prob = {}

	# 	dq = 0.to_f
	# 	pa = 0.to_f
	# 	ropes = 0.to_f
	# 	subm = 0.to_f
	# 	specialty = 0.to_f
	# 	xx = 0.to_f

	# 	array.each { |a|
	# 		if a[1] == 'ROPES'
	# 			ropes += a[0].to_f
	# 		elsif a[1] == '(S)'
	# 			specialty += a[0].to_f
	# 		elsif a[2] != nil
	# 			case a[2]
	# 			when '*'
	# 				binding.pry
	# 				subm += a[0].to_f
	# 			when '(DQ)'
	# 				dq += a[0].to_f
	# 			when '(XX)'
	# 				xx = a[0].to_f
	# 			when 'P/A'
	# 				pa += a[0].to_f
	# 			end
	# 		end
	# 	}
	# 		prob = { :specialty => specialty * gc_oc_roll, :subm => subm * gc_oc_roll, :dq => dq * gc_oc_roll, :xx => xx * gc_oc_roll, :pa => pa * gc_oc_roll, :ropes => ropes * gc_oc_roll }
	# end

end