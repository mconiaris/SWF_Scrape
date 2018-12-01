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
		oc_and_ropes_specialty_probability = calculate_specialty_dq_pa_subm_xx_probability(wrestler.values, '(S)')
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

		# Subtotals
		oc_points_per_roll_subtotal = calculate_oc_points_per_roll_subtotal(oc_points_per_roll, gc_oc_roll_probability)
		ropes_points_per_roll_subtotal = calculate_ropes_points_per_roll_subtotal(ropes_points_per_roll, gc_oc_roll_probability, ropes_roll_probability_hash[:OC])
		specialty_points_per_roll = calculate_specialty_points_and_attributes_per_round(specialty_points_and_attributes_hash, gc_oc_roll_probability, oc_and_ropes_specialty_probability, ropes_roll_probability_hash)

		# Calculate Total OC Points Per Roll
		ropes_points_per_roll_total = 
			specialty_points_per_roll[:ropes_points_per_roll] + 
			ropes_points_per_roll_subtotal
		
		oc_points_per_roll_total = 
			ropes_points_per_roll_total + 
			specialty_points_per_roll[:oc_points_per_roll] +
			oc_points_per_roll_subtotal

		dc_points_per_roll_total = 
			calculate_dc_points_per_round_subtotal(
				dc_points_without_reverse, 
				dc_reverse_roll_probability, 
				oc_points_per_roll_total)


			# Calculate Total Card Values
			card_points_per_round = oc_points_per_roll_total +
				dc_points_per_roll_total
			
			pa_probability_per_round = 
				calculate_total_dq_pa_sub_xx_per_round(
					gc_oc_roll_probability, 
					ropes_roll_probability_hash, 
					oc_and_ropes_pa_probability,
					specialty_roll_probability_hash,
					specialty_points_and_attributes_hash[:pa_probability])




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
		@statistics[:oc_probability] = gc_oc_roll_probability
		@statistics[:dc_probability] = gc_dc_roll_probability
		@statistics[:tt_probability] = calculate_gc_tt_roll_probability(wrestler.values)
		

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

		return @statistics
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

# Takes in the DC Points per roll (without Reverse)
# and adds them to (DC roll probability x Total OC points)
def calculate_dc_points_per_round_subtotal(
	dc_points, rev_prob, total_points)
	
	dc_points + (rev_prob * total_points)
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

	def calculate_oc_points_per_roll_subtotal(points, oc_prob)
		x = points * oc_prob
	end


	# ==========
	# ROPES CARD
	# ==========
	# Takes in the Ropes Points per GC Roll total and
	# multiplies it by the probablilty of rollinc OC and
	# then multip;ies it by the probability of rolling 
	# Ropes
	def calculate_ropes_points_per_roll_subtotal(points, oc_prob, ropes_prob)
		x = points * oc_prob * ropes_prob
	end


	# ==============
	# SPECIALTY CARD
	# ==============

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


	# Returns points per roll of (S) move for OC and
	# Ropes rolls.
	def calculate_specialty_points_and_attributes_per_round(hash, oc_prob, s_prob, ropes_prob)
		specialty_hash = Hash.new

		# Calculate Points Per OC (S) roll
		# (S) roll probability on OC x OC probability on GC x
		# Points per 1d6 (S) roll
		x = s_prob[:OC].to_f * oc_prob.to_f * hash[:points_average]
		specialty_hash[:oc_points_per_roll] = x

		# (S) roll probability on Ropes Card x OC 
		# probability on GC x Points per 1d6 (S) roll *
		# probability of rolling Ropes in OC
		y = s_prob[:R].to_f * oc_prob.to_f * 
			hash[:points_average] * ropes_prob[:OC]

 		specialty_hash[:ropes_points_per_roll] = y

 		return specialty_hash
	end



	# ==========
	# TOTAL CARD
	# ==========

	# oc_points_per_roll + 
	# (ropes_points_per_roll * ropes_roll_probability_hash[:OC] * ropes_points_per_roll)

	def calculate_subtotal_points_per_roll(probability, *args)
		total = 0
binding.pry
		total = probability * args
	end

# OC Version
# OC roll in GC (22/36)
# Move roll in OC (2/36)


# P/A per round OC + 
# P/A per round (S)


# pa_probability_per_round = 
# 				calculate_total_dq_pa_sub_xx_per_round(
# 					gc_oc_roll_probability, 
# 					ropes_roll_probability_hash, 
# 					oc_and_ropes_pa_probability,
# 					specialty_roll_probability_hash,
# 					specialty_points_and_attributes_hash[:pa_probability])



	# Calculate (DQ | P/A | * | XX) probability per Round
	def calculate_total_dq_pa_sub_xx_per_round(gc_oc_roll_prob, ropes_roll, attribute, s_prob, s_attribute)
		
		# Calculate OC (DQ | P/A | * | XX) probability 
		# per round without (S)
		x = gc_oc_roll_prob.to_f * attribute[:OC].to_f
		# Calculate (S) OC (DQ | P/A | * | XX) probability 
		# per round
		y = gc_oc_roll_prob.to_f * s_prob[:OC].to_f * s_attribute

		oc = x + y


		# Ropes (DQ | P/A | * | XX) probability per round
		# Calculate Ropes (DQ | P/A | * | XX) probability 
		# per round without (S)
		x_r = gc_oc_roll_prob.to_f * ropes_roll[:OC].to_f *
			attribute[:R].to_f
		# Calculate (S) Ropes (DQ | P/A | * | XX) probability 
		# per round
		y_r = gc_oc_roll_prob.to_f * ropes_roll[:OC].to_f *
			s_prob[:R].to_f * s_attribute

		r = x_r + y_r

		total = oc + r
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