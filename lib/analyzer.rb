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

		dc_points_without_reverse = 0
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
					dc_points_without_reverse += calculate_dc_points(key, value)
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
		
		# DC roll probability x Reverse roll probability
		dc_reverse_roll_probability = calculate_reverse_roll_probability(wrestler.values, gc_dc_roll_probability)
		dc_points_without_reverse = gc_dc_roll_probability * dc_points_without_reverse

		# 2d6 roll in Offensive and Ropes cards.
		dq_roll_probability_hash = calculate_specialty_dq_pa_subm_xx_probability(wrestler.values, '(DQ)')
		ropes_roll_probability_hash = calculate_specialty_dq_pa_subm_xx_probability(wrestler.values, 'ROPES')
		specialty_roll_probability_hash = calculate_specialty_dq_pa_subm_xx_probability(wrestler.values, '(S)')
		submission_move_roll_probability_hash = calculate_specialty_dq_pa_subm_xx_probability(wrestler.values, '*')
		xx_roll_probability_hash = calculate_specialty_dq_pa_subm_xx_probability(wrestler.values, '(XX)')

		# This is from the Specialty card only.
		specialty_points_and_attributes_hash = calculate_specialty_points_and_attributes(wrestler.values)

		# Calculate attributes of OC and Ropes cards
		# 2d6 x Offensive Card roll or 2d6 * Ropes Card roll
		oc_and_ropes_dq_probability = calculate_specialty_dq_pa_subm_xx_probability(wrestler.values, '(DQ)')
		oc_and_ropes_pa_probability = calculate_specialty_dq_pa_subm_xx_probability(wrestler.values, 'P/A')
		oc_and_ropes_subm_probability = calculate_specialty_dq_pa_subm_xx_probability(wrestler.values, '*')
		oc_and_ropes_xx_probability = calculate_specialty_dq_pa_subm_xx_probability(wrestler.values, '(XX)')

		# Seperate OC and Ropes cards and then calculate
		# points per roll
		oc_hash = wrestler.values.select { |k,v| k.to_s.include?('OC') }
		ropes_hash = wrestler.values.select { |k,v| k.to_s.include?('R') }
		
		# Takes the oc_hash and ropes_hash and calculates
		# the points per roll (2d6 * card). These values 
		# do not include Specialty rolls.
		oc_points_per_roll = calculate_oc_and_ropes_points(oc_hash)
		ropes_points_per_roll = calculate_oc_and_ropes_points(ropes_hash)

		# TODO: Create a total_points_per_roll method,
		# which should include OC card, Ropes card,
		# Specialty card and Reverse roll. This should be
		# multiplied by gc_oc probability.

		# TODO: Create a total_pa_probability_per_roll 
		# method,which should include OC card, Ropes card,
		# Specialty card and Reverse roll. This should be
		# multiplied by gc_oc probability.


		# TODO: Create a total_subm_probability_per_roll 
		# method,which should include OC card, Ropes card,
		# Specialty card and Reverse roll. This should be
		# multiplied by gc_oc probability.


		# TODO: Create a total_XX_probability_per_roll 
		# method,which should include OC card, Ropes card,
		# Specialty card and Reverse roll. This should be
		# multiplied by gc_oc probability.

		# TODO: Create a total_dq_probability_per_roll 
		# method,which should include OC card, Ropes card,
		# Specialty card and Reverse roll. This should be
		# multiplied by gc_oc probability.


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

	# Tabulates the A, B & C return values and multiplies
	# it by the probability of rolling them.
	def calculate_dc_points(k,v)
		case v
		when 'A'
			return DC_A * calculate_probability(k).to_f
		when 'B'
			# puts result
			return 0
		when 'C'
			# puts result
			return DC_C * calculate_probability(k).to_f
		when "REVERSE"
			# puts result
			return 0
		end
	end


	# ==============
	# OFFENSIVE CARD
	# ==============
	# TODO: Factor out analyssis into a method to DRY
	def calculate_oc_and_ropes_points(wrestler)

		points_per_roll_array = []


		wrestler.each { |k, v|
			a = v.split

			if a.last == '*'
				a.pop
				x = a.last.to_f * calculate_probability(k)
				points_per_roll_array << x
			elsif a.last == '(DQ)'
				x = 5 * calculate_probability(k)
				points_per_roll_array << x
			elsif a.last == 'P/A'
				a.pop
				x = a.last.to_f * calculate_probability(k)
				points_per_roll_array << x				
			elsif a.last == '(XX)'
				a.pop
				x = a.last.to_f * calculate_probability(k)
				points_per_roll_array << x
			else
				x = a.last.to_f * calculate_probability(k)
				points_per_roll_array << x
			end
		}
		return points_per_roll_array.sum
	end


	# Takes in a wrestler hash and calculates the
	# probability of either (S), (XX), * or (DQ) rolls.
	# It divides OC and Ropes cards into their own hashes,
	# determines the probabilities of both and then returns
	# the values in a hash.
	def calculate_specialty_dq_pa_subm_xx_probability(wrestler, move)
		s_prob = Hash.new
		s = wrestler.select { |k,v| v.include?(move) }
		s_oc = s.select { |k,v| k.to_s.include?('OC') }
		s_r = s.select { |k,v| k.to_s.include?('R') }

		s_oc_prob = 0
		s_r_prob = 0

		s_oc.each_key { |k| 
			s_oc_prob = calculate_probability(k)
		}

		# Does not include OC-Ropes roll probability
		s_r.each_key { |k| 
			s_r_prob = calculate_probability(k)
		}

		# Convert probability values into a hash
		s_prob[:OC] = s_oc_prob
		s_prob[:R] = s_r_prob

		return s_prob
	end


	# TODO factor out select hashes into a method for DRY
	# Isolate the Specialty move and calculate the
	# points and other values
	def calculate_specialty_points_and_attributes(wrestler)
		# Convert key Symbols to text and then isolate just
		# the keys with a single number after it.
		specialty_hash = Hash.new
		s_points = 0

		s = wrestler.select { |k,v| k.to_s =~ /S\d/ }

		# Calculate probability of a P/A roll in (S)
		s_sub_hash = s.select { |k,v| v.include?('*') }
		s_sub_prob = s_sub_hash.size / 6.to_f

		# Calculate probability of a DQ roll in (S)
		s_dq_hash = s.select { |k,v| v.include?('(DQ)') }
		s_dq_prob = s_dq_hash.size / 6.to_f

		# Calculate probability of a P/A roll in (S)
		s_pa_hash = s.select { |k,v| v.include?('P/A') }
		s_pa_prob = s_pa_hash.size / 6.to_f

		# Isolate integer values of (S) hash and sum them.
		s.each_value { |v| x = v.split
			s_points += x[0].to_i
		}
		s_points_average = s_points / 6

		specialty_hash[:dq_probability] = s_dq_prob
		specialty_hash[:pa_probability] = s_pa_prob
		specialty_hash[:points_average] = s_points_average
		specialty_hash[:submission_move_probability] = s_sub_prob
		return specialty_hash
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