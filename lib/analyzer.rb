class Analyzer

# TODO: Determine reason why this app and the other one come up with different results from total card rating.

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


	# ===================
	# GENERATE STATISTICS
	# ===================

	def analyze(wrestler)

		card_points_per_round = calculate_total_card_rating(wrestler)

		# Add values to wrestler's hash
		@statistics[:oc_probability] = wrestler.points[:oc_probability]
		@statistics[:dc_probability] = wrestler.points[:dc]
		@statistics[:tt_probability] = wrestler.points[:gc_tt_roll].to_f
		
		# Check for Problems in :Set attribute of hash.
		if wrestler.values[:set] == nil
			wrestler.values[:set] = 'Special'
		end

		return @statistics
	end


	# ======================
	# MOVE VALUES TO NUMBERS
	# ======================
	
	# Isolate Numbers from Text
	def move_points(hash)

		points = Hash.new

		gc_hash = hash.select { |k,v| k.to_s.include?('gc') }
		oc_hash = gc_hash.select { |k,v| v.include?('OC') }

		# Calculate OC count to calculate probablity.
		points[:oc_enumerator] = prob_points(oc_hash)
		points[:oc_probability] = return_rational(points[:oc_enumerator]).to_f
		points[:dc] = calculate_gc_dc_roll_probability(points[:oc_enumerator])

		# Calculate TT Roll in GC
		points[:gc_tt_enumerator] = calculate_gc_tt_roll_probability(hash)
		points[:gc_tt_roll] = return_rational(calculate_gc_tt_roll_probability(hash))
		
		# Create Symbols for Points
		for i in 2..12 do
			dc_points = "dc%02d_points" % i
			points[dc_points.to_sym] = 0
			i += 1
		end
		
		points[:reverse] = 0
		points[:specialty_roll_probability_in_oc] = 0

 		for i in 1..6 do
			s_points = "s#{i}_points"
			points[s_points.to_sym] = 0
			i += 1
		end

 		points[:s_roll_prob_dq] = 0
		points[:s_roll_prob_pa] = 0
		points[:s_roll_prob_sub] = 0
		points[:s_roll_prob_xx] = 0

		# TODO: Refactor this into one method
		for i in 2..12 do
			oc_points = "oc%02d_points" % i
			points[oc_points.to_sym] = 0
			i += 1
		end

		# TODO: Refactor this into one method
		for i in 2..12 do
			oc_dq = "oc%02d_dq" % i
			points[oc_dq.to_sym] = 0
			i += 1
		end

		# TODO: Refactor this into one method
		for i in 2..12 do
			oc_pa = "oc%02d_pa" % i
			points[oc_pa.to_sym] = 0
			i += 1
		end

		# TODO: Refactor this into one method
		for i in 2..12 do
			oc_sub = "oc%02d_sub" % i
			points[oc_sub.to_sym] = 0
			i += 1
		end

		# TODO: Refactor this into one method
		for i in 2..12 do
			oc_xx = "oc%02d_xx" % i
			points[oc_xx.to_sym] = 0
			i += 1
		end
		
 		points[:oc_ropes_roll_probability] = 0
 		points[:ropes_s_roll_probability] = 0

 		# TODO: Refactor this into one method
 		for i in 2..12 do
			r_points = "ro%02d_points" % i
			points[r_points.to_sym] = 0
			i += 1
		end

		# TODO: Refactor this into one method
		for i in 2..12 do
			r_dq = "ro%02d_dq" % i
			points[r_dq.to_sym] = 0
			i += 1
		end

		# TODO: Refactor this into one method
		for i in 2..12 do
			r_pa = "ro%02d_pa" % i
			points[r_pa.to_sym] = 0
			i += 1
		end

		# TODO: Refactor this into one method
		for i in 2..12 do
			r_sub = "ro%02d_sub" % i
			points[r_sub.to_sym] = 0
			i += 1
		end

		# TODO: Refactor this into one method
		for i in 2..12 do
			r_xx = "ro%02d_xx" % i
			points[r_xx.to_sym] = 0
			i += 1
		end

		points[:sub_numerator] = 0
		points[:tag_save_numerator] = 0

		# Determine Points for DC Rolls
		dc_hash = hash.select { |k,v| k.to_s.include?('dc') }
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
		r_hash = hash.select { |k,v| k.to_s.include?('dc') && v.downcase.include?('reverse') }
		points[:reverse] = prob_points(r_hash)

		# Determine (S) Points
		points[:s1_points] = hash[:s1].split[0].to_i
 		points[:s2_points] = hash[:s2].split[0].to_i
 		points[:s3_points] = hash[:s3].split[0].to_i
 		points[:s4_points] = hash[:s4].split[0].to_i
 		points[:s5_points] = hash[:s5].split[0].to_i
 		points[:s6_points] = hash[:s6].split[0].to_i

 		o_moves = hash.select { |k,v| k.to_s.include?('oc') }
 		o_moves.each { |k,v|
 			key = "#{k}_points".to_sym
 			m = remove_move(v)
 			points[key] = m
 		}

 		r_moves = hash.select { |k,v| k.to_s.include?('ro') }
 		r_moves.each { |k,v|
 			key = "#{k}_points".to_sym
 			m = remove_move(v)
 			points[key] = m
 		}

 		# Get Specialty Roll Numerator in OC
 		s = hash.select { |k,v| k.to_s.include?('oc') && v.include?('(S)') }
 		points[:specialty_roll_enumerator_in_oc] = prob_points(s)
 		points[:specialty_roll_probability_in_oc] = return_rational(points[:specialty_roll_enumerator_in_oc])

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
 		oc_ropes_hash = hash.select { |k,v| v == 'Ropes' }

 		points[:oc_ropes_roll_probability] = prob_points(oc_ropes_hash)

 		# Determine Enumerator of (S) rolls in Ropes
 		ropes_s_hash = hash.select { |k,v| k.to_s.include?("ro") && v.include?('(S)') }
 		points[:ropes_s_roll_probability] = prob_points(ropes_s_hash)

 		points[:prioritys] = hash[:prioritys].to_i
 		points[:priorityt] = hash[:priorityt].to_i

 		points[:sub_numerator] = sub_tag_numerator(hash[:sub])
 		points[:tag_save_numerator] = sub_tag_numerator(hash[:tag])

 		points[:sub_prob] = return_rational(points[:sub_numerator]).to_f
 		points[:tag_prob] = return_rational(points[:tag_save_numerator]).to_f

		return points
	end


	private


	# ==============================
	# METHODS TO GENERATE STATISTICS
	# ==============================

	def symbol_to_integer(key)
		key[-2..-1].to_i
	end


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
		elsif values.size == 1
			x = values[0].to_i
			num += calculate_probability(x)

		else
			puts "Sub or Tag numbers are out of range."				
		end
		return num
	end

	# Isolates P/A, DQ, xx or * results in Specialty
	# Card and returns the number of them.
	def get_s_extra_values(moves, value)
		h = moves.select { |k,v| k.to_s.include?('S') && v.include?(value) }
		return h.size
	end

	
	# Takes in all of the Wrestler moves and returns a
	# hash of the moves that contain either a P/A, DQ,
	# * or xx that is passed to it.
	def create_value_hash(moves, value)
		return moves.select { |k,v| v.include?(value)}
	end





	

	# ==========================
	# GENERATE TOTAL CARD RATING
	# ==========================

	# total_card_rating
	def calculate_total_card_rating(wrestler)
		
		oc_roll_probability = wrestler.points[:oc_probability]
		points_per_round = calculate_card_points_per_round(wrestler.points)
		dq_probability_per_round = calculate_dq_probability_per_round(wrestler.points)
		pa_probability_per_round = calculate_pa_probability_per_round(wrestler.points)
		sub_probability_per_round = calculate_sub_probability_per_round(wrestler.points)
		xx_probability_per_round = calculate_xx_probability_per_round(wrestler.points)
		
		# Double P/A per round and divide XX per round for total card value
		# to increase relative value of pin attempts.
		total_card_points = (points_per_round / 2) + 
			(oc_roll_probability * 10) +
			(dq_probability_per_round * 5) + 
			(pa_probability_per_round * 20) +
			(sub_probability_per_round * 10) + 
			(xx_probability_per_round * 5)

		singles_priority = wrestler.points[:prioritys]
		submission_loss_probabilty = wrestler.points[:sub_prob]

		total_card_rating = total_card_points + 10 + 
			singles_priority - (submission_loss_probabilty * 10)


		@statistics[:total_card_rating] = total_card_rating
		@statistics[:total_card_points] = total_card_points
		@statistics[:total_card_points_per_round] = points_per_round
		@statistics[:dq_probability_per_round] = dq_probability_per_round
		@statistics[:pa_probability_per_round] = pa_probability_per_round
		@statistics[:sub_probability_per_round] = sub_probability_per_round
		@statistics[:xx_probability_per_round] = xx_probability_per_round

		return total_card_rating
	end


	# card_points_per_round
	def calculate_card_points_per_round(wrestler)


		oc_points_per_round_total = 
			calculate_oc_points_per_round_total(wrestler)

		# DC points per round total
		dc_points_per_round_total = 
			calculate_dc_points_per_round_total(wrestler, oc_points_per_round_total)

		return dc_points_per_round_total + 
			oc_points_per_round_total
	end

	# dq_probability_per_round
	def calculate_dq_probability_per_round(wrestler)
		
		oc_dq_per_round_total = 
			calculate_oc_dq_per_round_total(wrestler)
		return oc_dq_per_round_total
	end


	# pa_probability_per_round
	def calculate_pa_probability_per_round(wrestler)
		oc_pa_per_round_total = 
			calculate_oc_pa_per_round_total(wrestler)
		return oc_pa_per_round_total
	end


	# sub_probability_per_round
	def calculate_sub_probability_per_round(wrestler)
		oc_sub_per_round_total = 
			calculate_oc_sub_per_round_total(wrestler)
		return oc_sub_per_round_total
	end


	# xx_probability_per_round
	def calculate_xx_probability_per_round(wrestler)
		oc_xx_per_round_total = 
			calculate_oc_xx_per_round_total(wrestler)
		return oc_xx_per_round_total
	end


	# wrestler.values[:PriorityS].to_f
	def calculate_submission_loss_probability
		
	end


	# 		sub_tag_probability(wrestler.values[:Sub])
	def calculate_tag_team_save_probability
		
	end


	# =========
	# UTILITIES
	# =========	

	# Takes in OC enumerator and divides it by 36
	def return_rational(numerator)
		numerator/36.to_r
	end

	def remove_attribute_from_key(k)
		k = k[0..3].to_sym
	end

	def return_attribute_hash(h, attribute)
		dq_hash = h.select { |k,v| k.to_s.include?(attribute) }
	end


	# ============
	# GENERAL CARD
	# ============

	# Takes in probability of an OC roll and uses it to
	# determine the probability of a DC roll.
	def calculate_gc_dc_roll_probability(oc_roll_probability)
		return 36/36.to_r - return_rational(oc_roll_probability)
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
	def calculate_dc_points_per_round_total(wrestler, oc_sub_total)
		# DC Points
		dc_hash = get_dc_card_hash(wrestler)
		
		dc_points_per_round_subtotal = 
			calculate_dc_points_per_round_subtotal(
				dc_hash, wrestler[:dc])

		# TODO: replace hard coded number with
		# total points variable
		rev_prob = return_rational(wrestler[:reverse])

		reverse_points_per_round = calculate_reverse_points(wrestler, oc_sub_total)
		# DC points per round total
		dc_points_per_round_total = 
			dc_points_per_round_subtotal +
			reverse_points_per_round

		return dc_points_per_round_total
	end

	def get_dc_card_hash(wrestler)
		h = wrestler.select { |k,v| k.to_s.include?("dc") }
		h.delete(:dc)
		return h
	end


	def calculate_reverse_round_probability(wrestler_hash, gc_dc_roll_probability)
		prob = return_rational(wrestler_hash[:reverse])

		return prob * gc_dc_roll_probability
	end


	# Multiplies DC roll point by probabiliy of rolling it.
	def calculate_dc_points_per_round_subtotal(hash, dc_prob)
			
			# Return sum of points per roll in DC
			x = 0
			hash.each { |k,v|
				k = remove_attribute_from_key(k)
				x += v.to_f * calculate_probability(symbol_to_integer(k))/36.to_f
			}

			# Return Points per DC Roll * DC Roll Probability
			return x
	end


	# DC Roll Probability * Reverse Roll in DC Probabiity *
	# Total OC Points Per Round
	def calculate_reverse_points(wrestler, oc_sub_total)
		reverse_points = wrestler[:dc] * 
			return_rational(wrestler[:reverse]) * oc_sub_total

		return reverse_points
	end




	# ==============
	# OFFENSIVE CARD
	# ==============

	# OC Points Subtotal + Ropes + Speci
	def calculate_oc_points_per_round_total(wrestler)

		oc_points_subtotal = 
			calculate_oc_points_subtotal(wrestler)

		oc_specialty_points_per_round = 
			calculate_oc_specialty_points_per_round(wrestler)

		ropes_points_total = 
			calculate_ropes_points_total(wrestler)

		oc_points_per_round_total = oc_points_subtotal +
			oc_specialty_points_per_round + ropes_points_total

		return oc_points_per_round_total
	end

	def calculate_oc_dq_per_round_total(wrestler)
		
		oc_dq_subtotal = 
			calculate_oc_dq_subtotal(wrestler)

		oc_specialty_dq_per_round = 
			calculate_oc_specialty_dq_per_round(wrestler)

		ropes_dq_total = 
			calculate_ropes_dq_total(wrestler)

		oc_dq_per_round_total = oc_dq_subtotal +
			oc_specialty_dq_per_round + ropes_dq_total
		
		return oc_dq_per_round_total
	end

	def calculate_oc_pa_per_round_total(wrestler)

		oc_pa_subtotal = 
			calculate_oc_pa_subtotal(wrestler)

		oc_specialty_pa_per_round = 
			calculate_oc_specialty_pa_per_round(wrestler)

		ropes_pa_total = 
			calculate_ropes_pa_total(wrestler)

		oc_pa_per_round_total = oc_pa_subtotal +
			oc_specialty_pa_per_round + ropes_pa_total
		return oc_pa_per_round_total
	end


	def calculate_oc_sub_per_round_total(wrestler)
		oc_sub_subtotal = 
			calculate_oc_sub_subtotal(wrestler)
		oc_specialty_sub_per_round = 
			calculate_oc_specialty_sub_per_round(wrestler)

		ropes_sub_total = 
			calculate_ropes_sub_total(wrestler)

		oc_sub_per_round_total = oc_sub_subtotal +
			oc_specialty_sub_per_round + ropes_sub_total
		return oc_sub_per_round_total
	end

	def calculate_oc_xx_per_round_total(wrestler)
		oc_xx_subtotal = 
			calculate_oc_xx_subtotal(wrestler)
		oc_specialty_xx_per_round = 
			calculate_oc_specialty_xx_per_round(wrestler)

		ropes_xx_total = 
			calculate_ropes_xx_total(wrestler)

		oc_xx_per_round_total = oc_xx_subtotal +
			oc_specialty_xx_per_round + ropes_xx_total
		return oc_xx_per_round_total
	end


	def get_oc_hash(wrestler)
		h = wrestler.select { |k,v| k.to_s.include?("oc") }
		return h
	end


	# specialty points average (total / 6) * 
	# oc_roll_probility * (S) probability
	def calculate_oc_specialty_points_per_round(wrestler)

		specialty_points_average = 
			calculate_specialty_points_average(wrestler)

		oc_specialty_points_per_round = 
			calculate_oc_specialty_per_round(
				wrestler, specialty_points_average)

		return oc_specialty_points_per_round
	end

	def calculate_oc_specialty_dq_per_round(wrestler)
		specialty_dq_average = 
			calculate_specialty_dq_average(wrestler)
	end

	def calculate_oc_specialty_pa_per_round(wrestler)
		specialty_pa_average = 
			calculate_specialty_pa_average(wrestler)

		oc_specialty_pa_per_round = 
			calculate_oc_specialty_per_round(
				wrestler, specialty_pa_average)
	end

	def calculate_oc_specialty_sub_per_round(wrestler)
		specialty_sub_average = 
			calculate_specialty_sub_average(wrestler)

		oc_specialty_sub_per_round = 
			calculate_oc_specialty_per_round(
				wrestler, specialty_sub_average)
	end


	def calculate_oc_specialty_xx_per_round(wrestler)
		specialty_xx_average = 
			calculate_specialty_xx_average(wrestler)

		oc_specialty_xx_per_round = 
			calculate_oc_specialty_per_round(
				wrestler, specialty_xx_average)
	end


	# OC points per roll total not including (S) or Ropes
	def calculate_oc_points_subtotal(wrestler)
		oc_prob = wrestler[:oc_probability]

		oc_hash = get_oc_hash(wrestler)
		oc_points_hash = oc_hash.select { |k,v| k.to_s.include?("points") }
		

		return calculate_oc_subtotal(oc_points_hash)
	end

	def calculate_oc_dq_subtotal(wrestler)
		oc_prob = wrestler[:oc_probability]

		dq_hash = return_attribute_hash(wrestler, "_dq")
		oc_dq_hash = return_attribute_hash(dq_hash, "oc")

		return calculate_dq_subtotal(oc_dq_hash)
	end

	def calculate_oc_pa_subtotal(wrestler)
		oc_prob = wrestler[:oc_probability]

		pa_hash = return_attribute_hash(wrestler, "_pa")
		oc_pa_hash = return_attribute_hash(pa_hash, "oc")

		pa_subtotal = calculate_pa_subtotal(oc_pa_hash)

		return pa_subtotal
	end

	def calculate_oc_sub_subtotal(wrestler)
		oc_prob = wrestler[:oc_probability]

		sub_hash = return_attribute_hash(wrestler, "_sub")
		oc_sub_hash = return_attribute_hash(sub_hash, "oc")

		sub_subtotal = calculate_sub_subtotal(oc_sub_hash)

		return sub_subtotal
	end

	def calculate_oc_xx_subtotal(wrestler)
		oc_prob = wrestler[:oc_probability]

		xx_hash = return_attribute_hash(wrestler, "_xx")
		oc_xx_hash = return_attribute_hash(xx_hash, "oc")

		xx_subtotal = calculate_xx_subtotal(oc_xx_hash)

		return xx_subtotal
	end


	# Takes in points, P/A, sub, etc. and 
	# Calculates the probability in the (S) card.
	def calculate_oc_specialty_per_round(
		wrestler, attribute)
		
		specialty_roll_prob = 
			wrestler[:specialty_roll_probability_in_oc]

		gc_oc_prob = wrestler[:oc_probability]

		oc_specialty_points_per_round = 
			attribute * specialty_roll_prob 

		return oc_specialty_points_per_round
	end

	
	# Takes in points, P/A, sub, etc. and 
	# Calculates the probability in the OC card.
	def calculate_oc_subtotal(wrestler)
		
		# Sum up points per roll * probability
		oc_points = 0
		wrestler.each { |k,v| 
			k = remove_attribute_from_key(k)
			prob = return_rational(calculate_probability(symbol_to_integer(k))).to_f
			oc_points += v * prob
		}

		oc_points_subtotal = oc_points
		return oc_points_subtotal
	end


	def calculate_dq_subtotal(wrestler)
		# Sum up points per roll * probability
		dq_points = 0
		wrestler.each { |k,v| 
			k = remove_attribute_from_key(k)
			prob = return_rational(calculate_probability(symbol_to_integer(k))).to_f
			dq_points += v * prob
		}

		dq_points_subtotal = dq_points
		return dq_points_subtotal
	end

	def calculate_pa_subtotal(wrestler)
		# Sum up points per roll * probability
		pa_points = 0
		wrestler.each { |k,v| 
			k = remove_attribute_from_key(k)
			prob = return_rational(calculate_probability(symbol_to_integer(k))).to_f
			pa_points += v * prob
		}

		pa_points_subtotal = pa_points
		return pa_points_subtotal
	end

	def calculate_sub_subtotal(wrestler)
		# Sum up points per roll * probability
		sub_points = 0
		wrestler.each { |k,v| 
			k = remove_attribute_from_key(k)
			prob = return_rational(calculate_probability(symbol_to_integer(k))).to_f
			sub_points += v * prob
		}

		sub_points_subtotal = sub_points
		return sub_points_subtotal
	end

	def calculate_xx_subtotal(wrestler)
		# Sum up points per roll * probability
		xx_points = 0
		wrestler.each { |k,v| 
			k = remove_attribute_from_key(k)
			prob = return_rational(calculate_probability(symbol_to_integer(k))).to_f
			xx_points += v * prob
		}

		xx_points_subtotal = xx_points
		return xx_points_subtotal
	end


	# ==========
	# ROPES CARD
	# ==========
	# Takes in the Ropes Points per GC Roll total and
	# multiplies it by the probablilty of rollinc OC and
	# then multip;ies it by the probability of rolling 
	# Ropes

	# Ropes Points Subtotal without (S)
	# 	points * oc_prob * ropes_prob
	def calculate_ropes_points_total(wrestler)

		ropes_specialty_points = 
			calculate_ropes_specialty_points(wrestler)
		ropes_points_per_roll_subtotal = 
			calculate_ropes_points_per_roll_total(wrestler)

		ropes_total = ropes_points_per_roll_subtotal + 
				ropes_specialty_points

		return ropes_total
	end

	def calculate_ropes_dq_total(wrestler)

		ropes_specialty_dq = 
			calculate_ropes_specialty_dq(wrestler)
		ropes_dq_per_roll_subtotal = 
			calculate_ropes_dq_per_roll_total(wrestler)

		ropes_dq_total = ropes_dq_per_roll_subtotal + 
				ropes_specialty_dq

		return ropes_dq_total
	end

	def calculate_ropes_pa_total(wrestler)
		
		ropes_specialty_pa = 
			calculate_ropes_specialty_pa(wrestler)
		ropes_pa_per_roll_subtotal = 
			calculate_ropes_pa_per_roll_total(wrestler)

		ropes_pa_total = ropes_pa_per_roll_subtotal + 
				ropes_specialty_pa

		return ropes_pa_total
	end

	def calculate_ropes_sub_total(wrestler)
		
		ropes_specialty_sub = 
			calculate_ropes_specialty_sub(wrestler)
		ropes_sub_per_roll_subtotal = 
			calculate_ropes_sub_per_roll_total(wrestler)

		ropes_sub_total = ropes_sub_per_roll_subtotal + 
				ropes_specialty_sub
	end


	def calculate_ropes_xx_total(wrestler)
		
		ropes_specialty_xx = 
			calculate_ropes_specialty_xx(wrestler)
		ropes_xx_per_roll_subtotal = 
			calculate_ropes_xx_per_roll_total(wrestler)

		ropes_xx_total = ropes_xx_per_roll_subtotal + 
				ropes_specialty_xx
	end


	def calculate_ropes_points_per_roll_total(wrestler)
		r_hash = get_ropes_hash(wrestler)
		r_points_hash = r_hash.select { |k,v| k.to_s.include?("_points") }

		calculate_ropes_per_roll_total(wrestler, r_points_hash)
	end

	def calculate_ropes_dq_per_roll_total(wrestler)
		r_hash = get_ropes_hash(wrestler)
		r_dq_hash = r_hash.select { |k,v| k.to_s.include?("_dq") }

		calculate_ropes_per_roll_total(wrestler, r_dq_hash)
	end

	def calculate_ropes_pa_per_roll_total(wrestler)
		r_hash = get_ropes_hash(wrestler)
		r_pa_hash = r_hash.select { |k,v| k.to_s.include?("_pa") }

		calculate_ropes_per_roll_total(wrestler, r_pa_hash)
	end


	def calculate_ropes_sub_per_roll_total(wrestler)
		r_hash = get_ropes_hash(wrestler)
		r_sub_hash = r_hash.select { |k,v| k.to_s.include?("_sub") }

		calculate_ropes_per_roll_total(wrestler, r_sub_hash)
	end


	def calculate_ropes_xx_per_roll_total(wrestler)
		r_hash = get_ropes_hash(wrestler)
		r_xx_hash = r_hash.select { |k,v| k.to_s.include?("_xx") }

		calculate_ropes_per_roll_total(wrestler, r_xx_hash)
	end


	def calculate_ropes_per_roll_total(wrestler, attribute)
		
		r_points = 0
		attribute.each { |k,v| 
			k = remove_attribute_from_key(k)
			prob = return_rational(calculate_probability(symbol_to_integer(k))).to_f
			r_points += v * prob
		}

		gc_oc_prob = wrestler[:oc_probability]
		ropes_roll_prob = return_rational(wrestler[:oc_ropes_roll_probability]).to_f

		r_points_subtotal = r_points * 
			ropes_roll_prob

		return r_points_subtotal
	end


	def calculate_ropes_specialty_points(wrestler)

		gc_oc_prob = wrestler[:oc_probability]
		ropes_roll_prob = return_rational(wrestler[:oc_ropes_roll_probability])
		ropes_s_roll_prob = return_rational(wrestler[:ropes_s_roll_probability])
		s_points_av = calculate_specialty_points_average(wrestler)
		
		s_points = ropes_roll_prob.to_f * 
			ropes_s_roll_prob * s_points_av

		return s_points
	end

	def calculate_ropes_specialty_dq(wrestler)
		gc_oc_prob = wrestler[:oc_probability]
		ropes_roll_prob = return_rational(wrestler[:oc_ropes_roll_probability])
		ropes_s_roll_prob = return_rational(wrestler[:ropes_s_roll_probability])
		s_dq_av = calculate_specialty_dq_average(wrestler)
		
		s_dq = ropes_roll_prob.to_f * 
			ropes_s_roll_prob * s_dq_av

		return s_dq
	end


	def calculate_ropes_specialty_pa(wrestler)
		
		gc_oc_prob = wrestler[:oc_probability]
		ropes_roll_prob = return_rational(wrestler[:oc_ropes_roll_probability])
		ropes_s_roll_prob = return_rational(wrestler[:ropes_s_roll_probability])
		s_pa_av = calculate_specialty_pa_average(wrestler)
		
		s_pa = ropes_roll_prob.to_f * 
			ropes_s_roll_prob * s_pa_av
		return s_pa
	end


	def calculate_ropes_specialty_sub(wrestler)
		gc_oc_prob = wrestler[:oc_probability]
		ropes_roll_prob = return_rational(wrestler[:oc_ropes_roll_probability])
		ropes_s_roll_prob = return_rational(wrestler[:ropes_s_roll_probability])
		s_sub_av = calculate_specialty_sub_average(wrestler)
		
		s_sub = ropes_roll_prob.to_f * 
			ropes_s_roll_prob * s_sub_av
		return s_sub
	end


	def calculate_ropes_specialty_xx(wrestler)
		gc_oc_prob = wrestler[:oc_probability]
		ropes_roll_prob = return_rational(wrestler[:oc_ropes_roll_probability])
		ropes_s_roll_prob = return_rational(wrestler[:ropes_s_roll_probability])
		s_xx_av = calculate_specialty_xx_average(wrestler)
		
		s_xx = ropes_roll_prob.to_f * 
			ropes_s_roll_prob * s_xx_av
		return s_xx
	end


	def get_ropes_hash(wrestler)
		h = wrestler.select { |k,v| k.to_s.include?("ro") }
		
		return h
	end






	# ==============
	# SPECIALTY CARD
	# ==============

	# Take in (S) hash, isolate points, add up points
	# and then divide by 6.
	def calculate_specialty_points_average(wrestler)
	
		s_hash = get_specialty_hash(wrestler)
		s_points_hash = s_hash.select { |k,v| k.to_s.include?("_points")}

		s_points = 0

		s_points_hash.each { |k,v| 
			s_points += v

		}
		return s_points/6.to_f
	end


	def calculate_specialty_dq_average(wrestler)
		s_hash = get_specialty_hash(wrestler)
		s_dq_hash = s_hash.select { |k,v| k.to_s.include?("_dq")}

		s_dq = 0

		s_dq_hash.each { |k,v| 
			s_dq += v

		}

		if s_dq == 0
			return 0
		end
		return s_dq/6.to_f
	end


	def calculate_specialty_pa_average(wrestler)
		s_hash = get_specialty_hash(wrestler)
		s_pa_hash = s_hash.select { |k,v| k.to_s.include?("_pa")}

		s_pa = 0

		s_pa_hash.each { |k,v| 
			s_pa += v
		}

		if s_pa == 0
			p_a_av = 0
		else
			p_a_av = s_pa/6.to_f
		end

		return p_a_av
	end


	def calculate_specialty_sub_average(wrestler)
		s_hash = get_specialty_hash(wrestler)
		s_sub_hash = s_hash.select { |k,v| k.to_s.include?("_sub")}

		s_sub = 0

		s_sub_hash.each { |k,v| 
			s_sub += v
		}

		if s_sub == 0
			av = 0
		else
			av = s_sub/6.to_f
		end

		return av
	end


	def calculate_specialty_xx_average(wrestler)
		s_hash = get_specialty_hash(wrestler)
		s_xx_hash = s_hash.select { |k,v| k.to_s.include?("_xx")}

		s_xx = 0

		s_xx_hash.each { |k,v| 
			s_xx += v
		}

		if s_xx == 0
			av = 0
		else
			av = s_pa/6.to_f
		end

		return av
	end


	def get_specialty_hash(wrestler)
		wrestler.select { |k,v| k.to_s =~ /s\d/ }
	end

end

