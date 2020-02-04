class Analyzer

	attr_accessor :statistics
	
	# Constants for Dice Rolls
	TWO_TWELVE = 1
	THREE_ELEVEN = 2
	FOUR_TEN = 3
	FIVE_NINE = 4
	SIX_EIGHT = 5
	SEVEN = 6

	# Constants for DC
	DC_A = 2
	DC_B = 0
	DC_C = 4
	DC_R = 1

	def initialize
		@statistics = Hash.new
	end


	# ======================
	# MOVE VALUES TO NUMBERS
	# ======================
	
	# Isolate Numbers from Text
	def move_points(hash)
		points = Hash.new

		gc_hash = hash.select { |k,v| k.to_s.include?('GC') }
		oc_hash = gc_hash.select { |k,v| v.include?('OC') }

		# Calculate OC count to calculate probablity.
		points[:OC] = prob_points(oc_hash)
		points[:DC] = 36 - points[:OC]

		# Calculate TT Roll in GC
		r_hash = hash.select { |k,v| v.include?('OC/TT') }
		points[:GC_TT_Roll] = prob_points(r_hash)

		
		# Create Symbols for Points
		for i in 2..12 do
			dc_points = "DC%02d_points" % i
			points[dc_points.to_sym] = 0
			i += 1
		end
		
		points[:Reverse] = 0
		points[:Specialty_Roll_Probability_in_OC] = 0

 		for i in 1..6 do
			s_points = "S#{i}_points"
			points[s_points.to_sym] = 0
			i += 1
		end

 		points[:s_roll_prob_dq] = 0
		points[:s_roll_prob_pa] = 0
		points[:s_roll_prob_sub] = 0
		points[:s_roll_prob_xx] = 0

		# TODO: Refactor this into one method
		for i in 2..12 do
			oc_points = "OC%02d_points" % i
			points[oc_points.to_sym] = 0
			i += 1
		end

		# TODO: Refactor this into one method
		for i in 2..12 do
			oc_dq = "OC%02d_dq" % i
			points[oc_dq.to_sym] = 0
			i += 1
		end

		# TODO: Refactor this into one method
		for i in 2..12 do
			oc_pa = "OC%02d_pa" % i
			points[oc_pa.to_sym] = 0
			i += 1
		end

		# TODO: Refactor this into one method
		for i in 2..12 do
			oc_sub = "OC%02d_sub" % i
			points[oc_sub.to_sym] = 0
			i += 1
		end

		# TODO: Refactor this into one method
		for i in 2..12 do
			oc_xx = "OC%02d_xx" % i
			points[oc_xx.to_sym] = 0
			i += 1
		end
		
 		points[:OC_Ropes_Roll_Probability] = 0
 		points[:Ropes_S_Roll_Probability] = 0

 		# TODO: Refactor this into one method
 		for i in 2..12 do
			r_points = "RO%02d_points" % i
			points[r_points.to_sym] = 0
			i += 1
		end

		# TODO: Refactor this into one method
		for i in 2..12 do
			r_dq = "RO%02d_dq" % i
			points[r_dq.to_sym] = 0
			i += 1
		end

		# TODO: Refactor this into one method
		for i in 2..12 do
			r_pa = "RO%02d_pa" % i
			points[r_pa.to_sym] = 0
			i += 1
		end

		# TODO: Refactor this into one method
		for i in 2..12 do
			r_sub = "RO%02d_sub" % i
			points[r_sub.to_sym] = 0
			i += 1
		end

		# TODO: Refactor this into one method
		for i in 2..12 do
			r_xx = "RO%02d_xx" % i
			points[r_xx.to_sym] = 0
			i += 1
		end

		points[:sub_numerator] = 0
		points[:tag_save_numerator] = 0

		# Determine Points for DC Rolls
		dc_hash = hash.select { |k,v| k.to_s.include?('DC') }
		dc_hash.each { | k,v|
			if v == "A"
				points["#{k}_points".to_sym] = DC_A
			elsif v == "C"
				points["#{k}_points".to_sym] = DC_C
			else
				points["#{k}_points".to_sym] = DC_B
			end
		}

		# Calculate Reverse Roll in DC
		reverse_roll = 0
		r_hash = hash.select { |k,v| v.include?('Reverse') && k.to_s.include?('DC') }
		points[:Reverse] = prob_points(r_hash)

		# Determine (S) Points
		points[:S1_points] = hash[:S1].split[0].to_i
 		points[:S2_points] = hash[:S2].split[0].to_i
 		points[:S3_points] = hash[:S3].split[0].to_i
 		points[:S4_points] = hash[:S4].split[0].to_i
 		points[:S5_points] = hash[:S5].split[0].to_i
 		points[:S6_points] = hash[:S6].split[0].to_i

 		o_moves = hash.select { |k,v| k.to_s.include?('OC') }
 		o_moves.each { |k,v|
 			key = "#{k}_points".to_sym
 			m = remove_move(v)
 			points[key] = m
 		}

 		r_moves = hash.select { |k,v| k.to_s.include?('RO') }
 		r_moves.each { |k,v|
 			key = "#{k}_points".to_sym
 			m = remove_move(v)
 			points[key] = m
 		}

 		# Get Specialty Roll Numerator in OC
 		s = hash.select { |k,v| k.to_s.include?('OC') && v.include?('(S)') }
 		points[:Specialty_Roll_Probability_in_OC] = prob_points(s)

 		# Get Specialty Roll Probability-DQ (x/6)
 		points[:s_roll_prob_dq] = get_s_extra_values(hash, '(DQ)')
 		points[:s_roll_prob_pa] = get_s_extra_values(hash, 'P/A')
		points[:s_roll_prob_sub] = get_s_extra_values(hash, '*')
		points[:s_roll_prob_xx] = get_s_extra_values(hash, '(xx)')
 			
		# Find DQ, P/A, * and XX Values in OC and Ropes
 		dq_hash = create_value_hash(hash, "(DQ)")
 		pa_hash = create_value_hash(hash, "P/A")
 		sub_hash = create_value_hash(hash, "*")
 		xx_hash = create_value_hash(hash, "(xx)")

 		dq_hash.each { |k,v| 
 			key = k.to_s + "_dq"
 			points[key.to_sym] = 1
 		}

		pa_hash.each { |k,v| 
 			key = k.to_s + "_pa"
 			points[key.to_sym] = 1
 		} 	

 		sub_hash.each { |k,v| 
 			key = k.to_s + "_sub"
 			points[key.to_sym] = 1
 		}

 		xx_hash.each { |k,v| 
 			key = k.to_s + "_xx"
 			points[key.to_sym] = 1
 		}

 		# Determine Ropes Roll Enumerator
 		oc_ropes_hash = hash.select { |k,v| v.include?('Ropes') }
 		points[:OC_Ropes_Roll_Probability] = prob_points(oc_ropes_hash)

 		# Determine Enumerator of (S) rolls in Ropes
 		ropes_s_hash = hash.select { |k,v| k.to_s.include?("RO") && v.include?('(S)') }
 		points[:Ropes_S_Roll_Probability] = prob_points(ropes_s_hash)

 		points[:sub_numerator] = sub_tag_numerator(hash[:Sub])
 		points[:tag_save_numerator] = sub_tag_numerator(hash[:Tag])

		return points
	end


	# ==============================
	# METHODS TO GENERATE STATISTICS
	# ==============================

	def symbol_to_integer(key)
		key[-2..-1].to_i
	end


	# TODO: replace all pro_points with this
	# 2d6 roll so that it can be used to calculate the
	# probabilty of rolls for GC, OC & DC.
	def calculate_probability(key)

		k = key

		case k
		when 2
			return TWO_TWELVE
		when 3
			return THREE_ELEVEN
		when 4
			return FOUR_TEN
		when 5
			return FIVE_NINE
		when 6
			return SIX_EIGHT
		when 7
			return SEVEN
		when 8
			return SIX_EIGHT
		when 9
			return FIVE_NINE
		when 10
			return FOUR_TEN
		when 11
			return THREE_ELEVEN
		when 12
			return TWO_TWELVE
		else
			return 0
		end
	end
	

	def remove_move(move)
		m = move.split

		if m.size == 1
			return 0
		elsif m.last == "(S)" || m.last == "Ropes"
			return 0
		elsif m.last == "(DQ)"
			return 5
		elsif m.last.to_i == 0
			return m[m.length-2].to_i
		elsif m.last.to_i != 0
			return m.last.to_i
		else
			return "Error"
		end
	end


	def prob_points(move)
		# Calculate OC count to calculate probablity.
		count = 0
		move.each_key { |k|
			count += calculate_probability(symbol_to_integer(k))
		}
		return count
	end


	# Takes in Wrestler Values Array of Sub values, 
	# converts them to integers and then a range and
	# determines the probabillity of a submission.
	def sub_tag_numerator(values)
		num = 0

		if values.size == 2
			s = Range.new(values[0].to_i, values[1].to_i)
			s.each { |x|
				num += calculate_probability(x)
			}
		elsif a.size == 1
			x = values[0].to_i
			num += calculate_probability(x)
		else
			puts "Sub or Tag numbers are out of range."				
		end
		return num
	end
























	

	# Generate the 
	def get_extra_values(moves, value)
		binding.pry
		h = moves.select { |k,v| v.include?(value) }
	end

	def get_s_extra_values(moves, value)
		h = moves.select { |k,v| k.to_s.include?('S') && v.include?(value) }
		return h.size
	end

	def create_value_hash(moves, value)
		return moves.select { |k,v| v.include?(value)}
	end




















	# ===================
	# GENERATE STATISTICS
	# ===================

	def analyze(wrestler)

		dc_points_without_reverse = 0
		dc_reverse_roll_probability = 0


		# Determine DC Points per roll
		dc_hash = wrestler.points.select { |k,v| 
			k.to_s.include?("DC")
		}
		dc_points_without_reverse = calculate_dc_points(dc_hash)


		# Generate probabiity of OC roll in GC
		gc_oc_roll_probability = calculate_gc_oc_roll_probability(wrestler.points[:OC])

		# Calculate temporary Variables
		gc_dc_roll_probability = calculate_gc_dc_roll_probability(gc_oc_roll_probability)
		
		# DC roll probability x Reverse roll probability
		dc_reverse_roll_probability = calculate_reverse_roll_probability(wrestler.points, gc_dc_roll_probability)

		dc_points_without_reverse = gc_dc_roll_probability * dc_points_without_reverse





		# 2d6 roll in Offensive and Ropes cards.
		dq_roll_probability_hash = calculate_specialty_dq_pa_subm_xx_probability(wrestler.values, '(DQ)')
		ropes_roll_probability_hash = calculate_specialty_dq_pa_subm_xx_probability(wrestler.values, 'ROPES')
		specialty_roll_probability_hash = calculate_specialty_dq_pa_subm_xx_probability(wrestler.values, '(S)')
		submission_move_roll_probability_hash = calculate_specialty_dq_pa_subm_xx_probability(wrestler.values, '*')
		xx_roll_probability_hash = calculate_specialty_dq_pa_subm_xx_probability(wrestler.values, '(xx)')

		# This is from the Specialty card only.
		specialty_points_and_attributes_hash = calculate_specialty_points_and_attributes(wrestler.values)

		# Calculate attributes of OC and Ropes cards
		# 2d6 x Offensive Card roll or 2d6 * Ropes Card roll
		oc_and_ropes_dq_probability = calculate_specialty_dq_pa_subm_xx_probability(wrestler.values, '(DQ)')
		oc_and_ropes_pa_probability = calculate_specialty_dq_pa_subm_xx_probability(wrestler.values, 'P/A')
		oc_and_ropes_specialty_probability = calculate_specialty_dq_pa_subm_xx_probability(wrestler.values, '(S)')
		oc_and_ropes_subm_probability = calculate_specialty_dq_pa_subm_xx_probability(wrestler.values, '*')
		oc_and_ropes_xx_probability = calculate_specialty_dq_pa_subm_xx_probability(wrestler.values, '(xx)')

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
			
			dq_probability_per_round = 
				calculate_total_dq_pa_sub_xx_per_round(
					gc_oc_roll_probability, 
					ropes_roll_probability_hash, 
					oc_and_ropes_dq_probability,
					specialty_roll_probability_hash,
					specialty_points_and_attributes_hash[:dq_probability])

			pa_probability_per_round = 
				calculate_total_dq_pa_sub_xx_per_round(
					gc_oc_roll_probability, 
					ropes_roll_probability_hash, 
					oc_and_ropes_pa_probability,
					specialty_roll_probability_hash,
					specialty_points_and_attributes_hash[:pa_probability])

				sub_probability_per_round = 
				calculate_total_dq_pa_sub_xx_per_round(
					gc_oc_roll_probability, 
					ropes_roll_probability_hash, 
					oc_and_ropes_subm_probability,
					specialty_roll_probability_hash,
					specialty_points_and_attributes_hash[:submission_move_probability])

				xx_probability_per_round = 
				calculate_total_dq_pa_sub_xx_per_round(
					gc_oc_roll_probability, 
					ropes_roll_probability_hash, 
					oc_and_ropes_xx_probability,
					specialty_roll_probability_hash,
					0)

		# Adds up the points_per_round with the probability
		# of rolling P/A, Sub, XX, or DQ and then subtracts
		# it by the probability of submission.
		total_card_rating = card_points_per_round +
			dq_probability_per_round + 
			pa_probability_per_round + 
			sub_probability_per_round + 
			xx_probability_per_round +
			wrestler.values[:PriorityS].to_f -
			sub_tag_probability(wrestler.values[:Sub])


		# Revise Wrestler Priority Numbers


		# Add values to wrestler's hash
		@statistics[:oc_probability] = gc_oc_roll_probability
		@statistics[:dc_probability] = gc_dc_roll_probability
		@statistics[:tt_probability] = calculate_gc_tt_roll_probability(wrestler.values)
		@statistics[:oc_card_points_per_round] = oc_points_per_roll_total
		@statistics[:dc_card_points_per_round] = dc_points_per_roll_total
		@statistics[:total_card_points_per_round] = card_points_per_round
		@statistics[:dq_probability_per_round] = dq_probability_per_round
		@statistics[:pa_probability_per_round] = pa_probability_per_round
		@statistics[:sub_probability_per_round] = sub_probability_per_round
		@statistics[:xx_probability_per_round] = xx_probability_per_round
		@statistics[:submission_loss_probabilty] = sub_tag_probability(wrestler.values[:Sub])
		@statistics[:tag_team_save_probabilty] = sub_tag_probability(wrestler.values[:Tag])
		@statistics[:card_rating] = total_card_rating
		

		return @statistics
	end




	# ============
	# GENERAL CARD
	# ============

	# Takes in OC enumerator and divides it by 36
	def calculate_gc_oc_roll_probability(oc)
		oc/36.to_r
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
			|k| prob += calculate_probability(symbol_to_integer(k))
		}

		return prob
	end


	# ==============
	# DEFENSIVE CARD
	# ==============
	# Takes in wrestler card hash Reverse probabilty
	# and multiplies it by the probability of rolling
	# the DC card.
	def calculate_reverse_roll_probability(wrestler_hash, gc_dc_roll_probability)

		prob = wrestler_hash[:Reverse]/36.to_r

		return prob * gc_dc_roll_probability
	end


	# Multiplies DC roll point by probabiliy of rolling it.
	def calculate_dc_points(hash)

			# Remove DC Roll from hash
			hash.delete(:DC)
			# Return sum of points per roll * probability
			x = 0
			hash.each { |k,v|
				k = k.to_s.delete("_points")
				x += v.to_f * calculate_probability(symbol_to_integer(k))/36.to_f
			}
			return x
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
				x = a.last.to_f * calculate_probability(symbol_to_integer(k))
				points_per_roll_array << x
			elsif a.last == '(DQ)'
				x = 5 * calculate_probability(symbol_to_integer(k))
				points_per_roll_array << x
			elsif a.last == 'P/A'
				a.pop
				x = a.last.to_f * calculate_probability(symbol_to_integer(k))
				points_per_roll_array << x				
			elsif a.last == '(xx)'
				a.pop
				x = a.last.to_f * calculate_probability(symbol_to_integer(k))
				points_per_roll_array << x
			else
				x = a.last.to_f * calculate_probability(symbol_to_integer(k))
				points_per_roll_array << x
			end
		}
		return points_per_roll_array.sum
	end

	# Takes in average points per OC and multiplies
	# it by the probability of rolling OC
	def calculate_oc_points_per_roll_subtotal(points, oc_prob)
		points * oc_prob
	end


	# ==========
	# ROPES CARD
	# ==========
	# Takes in the Ropes Points per GC Roll total and
	# multiplies it by the probablilty of rollinc OC and
	# then multip;ies it by the probability of rolling 
	# Ropes
	def calculate_ropes_points_per_roll_subtotal(points, oc_prob, ropes_prob)
		points * oc_prob * ropes_prob
	end


	# ==============
	# SPECIALTY CARD
	# ==============

	# TODO: Check to see if DQ and XX is calculated somewhere else

	# Takes in a wrestler hash and calculates the
	# probability of either (S), (XX), * or (DQ) rolls.
	# It divides OC and Ropes cards into their own hashes,
	# determines the probabilities of both and then returns
	# the values in a hash.
	def calculate_specialty_dq_pa_subm_xx_probability(wrestler, move)

		s_prob = Hash.new

		# Check for Problems in :Set attribute of hash.
		if wrestler[:Set] == nil
			wrestler[:Set] = 'Special'
		end

		# Check for nil valcues
		s = wrestler.select { |k,v| v.include?(move) }
		s_oc = s.select { |k,v| k.to_s.include?('OC') }
		s_r = s.select { |k,v| k.to_s.include?('R') }

		s_oc_prob = 0
		s_r_prob = 0

		s_oc.each_key { |k| 
			s_oc_prob += calculate_probability(symbol_to_integer(k))
		}

		# Does not include OC-Ropes roll probability
		s_r.each_key { |k| 
			s_r_prob += calculate_probability(symbol_to_integer(k))
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
		s_dq_hash = s.select { |k,v| v.include?('DQ') }
		s_dq_prob = s_dq_hash.size / 6.to_f

		# Calculate probability of a P/A roll in (S)
		s_pa_hash = s.select { |k,v| v.include?('P/A') }
		s_pa_prob = s_pa_hash.size / 6.to_f

		# Isolate integer values of (S) hash and sum them.
		s.each_value { |v| x = v.split
			s_points += x[0].to_i
		}
		# Calculate Average Points from DQ Rolls
		dq_points = s_dq_hash.size * 5
		s_points += dq_points

		s_points_average = s_points / 6.to_f


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

		oc + r
	end

	# Takes SUB or TAG values and calculates probability 
	# a card rolling that range.
	def sub_tag_probability(a)
		num_range = 0

		if a.size == 2
			s = Range.new(a[0].to_i, a[1].to_i)

			s.each { |x|
				num_range += calculate_probability(x)
			}
		elsif a.size == 1
			x = a[0].to_i
			num_range += calculate_probability(x)
		else
			puts "Sub or Tag numbers are out of range."				
		end

		return num_range.to_f
	end
end

