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
		points[:OC_enumerator] = prob_points(oc_hash)
		points[:oc_probability] = return_rational(points[:OC_enumerator]).to_f
		points[:DC] = calculate_gc_dc_roll_probability(points[:OC_enumerator])

		# Calculate TT Roll in GC
		points[:GC_TT_Roll] = return_rational(calculate_gc_tt_roll_probability(hash))
		
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
 		points[:Specialty_Roll_Enumerator_in_OC] = prob_points(s)
 		points[:Specialty_Roll_Probability_in_OC] = return_rational(points[:Specialty_Roll_Enumerator_in_OC])

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

 		points[:Sub_prob] = return_rational(points[:sub_numerator]).to_f
 		points[:Tag_prob] = return_rational(points[:tag_save_numerator]).to_f

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

	# total_card_rating = card_points_per_round +
	# 		dq_probability_per_round + 
	# 		pa_probability_per_round + 
	# 		sub_probability_per_round + 
	# 		xx_probability_per_round +
	# 		wrestler.values[:PriorityS].to_f -
	# 		sub_tag_probability(wrestler.values[:Sub])

	# total_card_rating
	def calculate_total_card_rating(wrestler)
		calculate_card_points_per_round(wrestler.points)
	end


	# card_points_per_round
	def calculate_card_points_per_round(wrestler)

		# DC points per round total
		dc_points_per_round_total = 
			calculate_dc_points_per_round_total(wrestler)

		oc_points_per_round_total = 
			calculate_oc_points_per_round_total(wrestler)

		return dc_points_per_round_total + 
			oc_points_per_round_total +
			0
	end


	def calculate_dc_points_per_round_total(wrestler)
		# DC Points
		dc_hash = get_dc_card_hash(wrestler)
		
		dc_points_per_round_subtotal = 
			calculate_dc_points_per_round_subtotal(
				dc_hash, wrestler[:DC])

		# TODO: replace hard coded number with
		# total points variable
		rev_prob = return_rational(wrestler[:Reverse])
		reverse_points_per_round = calculate_reverse_points_per_round_subtotal(
			wrestler[:DC], rev_prob, 4.65406378600823)

		# DC points per round total
		dc_points_per_round_total = 
			dc_points_per_round_subtotal +
			reverse_points_per_round

		return dc_points_per_round_total + 0
	end


	# dq_probability_per_round
	def calculate_dq_probability_per_round
		
	end


	# pa_probability_per_round
	def calculate_pa_probability_per_round
		
	end


	# sub_probability_per_round
	def calculate_sub_probability_per_round
		
	end


	# xx_probability_per_round
	def calculate_xx_probability_per_round
		
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

	def remove_attribute_from_key(k, attribute)
		k = k.to_s.delete(attribute).to_sym
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
	def get_dc_card_hash(wrestler)
		h = wrestler.select { |k,v| k.to_s.include?("DC") }
		h.delete(:DC)
		return h
	end


	def calculate_reverse_round_probability(wrestler_hash, gc_dc_roll_probability)
		prob = return_rational(wrestler_hash[:Reverse])

		return prob * gc_dc_roll_probability
	end


	# Multiplies DC roll point by probabiliy of rolling it.
	def calculate_dc_points_per_round_subtotal(hash, dc_prob)
			
			# Return sum of points per roll in DC
			x = 0
			hash.each { |k,v|
				k = remove_attribute_from_key(k, "_points")
				x += v.to_f * calculate_probability(symbol_to_integer(k))/36.to_f
			}

			# Return Points per DC Roll * DC Roll Probability
			return x * dc_prob
	end

	def calculate_reverse_points_per_round_subtotal(dc_roll_prob, rev_prob, total_points)
		dc_roll_prob * rev_prob * total_points
	end






	# ==============
	# OFFENSIVE CARD
	# ==============

	def calculate_oc_points_per_round_total(wrestler)
		oc_specialty_points_per_round = 
			calculate_oc_specialty_points_per_round(wrestler)
	end


	# specialty points average (total / 6) * 
	# oc_roll_probility * (S) probability
	def calculate_oc_specialty_points_per_round(wrestler)
		specialty_points_average = 
			calculate_specialty_points_average(wrestler)
			binding.pry
	end


	

	# TODO: Factor out analyssis into a method to DRY
	def calculate_oc_and_ropes_points(wrestler)
	# 	# points_per_roll_array = []
	# 	points_per_roll = 0

	# 	wrestler.each { |k,v|
	# 		k = k.to_s.delete("_points").to_sym
	# 		points_per_roll += (v * return_rational(calculate_probability(symbol_to_integer(k))).to_f)
	# 	}

	# 	return points_per_roll
	end

	# # Takes in average points per OC and multiplies
	# # it by the probability of rolling OC
	def calculate_oc_points_per_roll_subtotal(points, oc_prob)
	# 	points * oc_prob
	end






	# ==========
	# ROPES CARD
	# ==========
	# Takes in the Ropes Points per GC Roll total and
	# multiplies it by the probablilty of rollinc OC and
	# then multip;ies it by the probability of rolling 
	# Ropes
	def calculate_ropes_points_per_roll_subtotal(points, oc_prob, ropes_prob)
	# 	points * oc_prob * ropes_prob
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


	def get_specialty_hash(wrestler)
		wrestler.select { |k,v| k.to_s =~ /S\d/ }
	end
	# TODO: Check to see if DQ and XX is calculated somewhere else

	# Takes in a wrestler hash and calculates the
	# probability of either (S), (XX), * or (DQ) rolls.
	# It divides OC and Ropes cards into their own hashes,
	# determines the probabilities of both and then returns
	# the values in a hash.
	def calculate_specialty_dq_pa_subm_xx_probability(wrestler, move)
	# 	s_prob = Hash.new

	# 	# Check for nil valcues
	# 	s = wrestler.select { |k,v| k.to_s.include?(move) && v == 1 }
	# 	s_oc = s.select { |k,v| k.to_s.include?('OC') }
	# 	s_r = s.select { |k,v| k.to_s.include?('R') }

	# 	s_oc_prob = 0
	# 	s_r_prob = 0

	# 	s_oc.each_key { |k| 
	# 		x = x = k[0..3]
	# 		k = x.to_sym
	# 		s_oc_prob += calculate_probability(symbol_to_integer(k))
	# 	}

	# 	# Does not include OC-Ropes roll probability
	# 	s_r.each_key { |k| 
	# 		x = x = k[0..3]
	# 		k = x.to_sym
	# 		s_r_prob += calculate_probability(symbol_to_integer(k))
	# 	}

	# 	# Convert probability values into a hash
	# 	s_prob[:OC] = s_oc_prob
	# 	s_prob[:R] = s_r_prob

	# 	return s_prob
	end


	# TODO factor out select hashes into a method for DRY
	# Isolate the Specialty move and calculate the
	# points and other values
	def calculate_average_specialty_points_per_round(wrestler)
		
	# 	s_points = 0

	# 	s = wrestler.select { |k,v| k.to_s =~ /S\d/ && k.to_s.include?("_points")}
	# 	s.each { |k, v| s_points += v }

	# 	return s_points/6.to_f
	end


	# Returns points per roll of (S) move for OC and
	# Ropes rolls.
	def calculate_specialty_points_and_attributes_per_round(s_points, oc_prob, s_prob, ropes_prob)
	# 	specialty_hash = Hash.new

	# 	# Calculate Points Per OC (S) roll
	# 	# (S) roll probability on OC x OC probability on GC x
	# 	# Points per 1d6 (S) roll
	# 	x = return_rational(s_prob[:OC].to_f) * oc_prob.to_f * s_points
	# 	specialty_hash[:oc_points_per_roll] = x

	# 	# (S) roll probability on Ropes Card x OC 
	# 	# probability on GC x Points per 1d6 (S) roll *
	# 	# probability of rolling Ropes in OC
	# 	y = return_rational(s_prob[:R].to_f) * oc_prob.to_f * 
	# 		s_points * ropes_prob

 # 		specialty_hash[:ropes_points_per_roll] = y

 # 		return specialty_hash
	end


# OC





	# ==========
	# TOTAL CARD
	# ==========
# wrestler.points[:OC=>22]/36 * OC_attribute: (dq, p/a, xx or sub)
# wrestler.points[:OC=>22]/36 * OC_S_probability * S_prob_attribute

	# Calculate (DQ | P/A | * | XX) probability per Round
	def calculate_total_dq_pa_sub_xx_per_round(attribute, wrestler)
	# 	# Generate Proabilities of attribute (dq, p/a, sub or xx)
	# 	# to be rolled in OC card.
	# 	h = wrestler.select { |k,v| k.to_s.include?(attribute) && v == 1 }

	# 	oc_h = h.select { |k,v| k.to_s.include?("OC") }
	# 	oc_prob = 0
	# 	oc_h.each { |k,v| 
	# 		k = k.to_s.delete(attribute).to_sym
	# 		oc_prob += calculate_probability(symbol_to_integer(k)) * v 
	# 	}

	# 	# Generate Proabilities of attribute (dq, p/a, sub or xx)
	# 	# to be rolled in Ropes card.
	# 	r_h = h.select { |k,v| k.to_s.include?("RO") }
	# 	r_prob = 0
	# 	r_h.each { |k,v| 
	# 		k = k.to_s.delete(attribute).to_sym
	# 		r_prob += calculate_probability(symbol_to_integer(k)) * v }


	# 	# Calculate OC (DQ | P/A | * | XX) probability 
	# 	# per round without (S)
	# 	x = return_rational(wrestler[:OC]).to_f * oc_prob

	# 	# Calculate Specialty Card proability of 
	# 	# OC (DQ | P/A | * | XX) probability per round
	# 	# First Dynamically generate symbol go get (S) Value
	# 	symb = "s_roll_prob" + attribute
	# 	symb = symb.to_sym

	# 	# Create Probability
	# 	y = return_rational(wrestler[:OC]).to_f * 
	# 		return_rational(wrestler[symb]).to_f * 
	# 		return_rational(wrestler[:Specialty_Roll_Probability_in_OC]).to_f

	# 	oc = x + y


	# 	# Ropes (DQ | P/A | * | XX) probability per round
	# 	# Calculate Ropes (DQ | P/A | * | XX) probability 
	# 	# per round without (S)
	# 	x_r = return_rational(wrestler[:OC]).to_f * 
	# 		return_rational(wrestler[:OC_Ropes_Roll_Probability]).to_f *
	# 		r_prob

	# 	# Calculate (S) Ropes (DQ | P/A | * | XX) probability 
	# 	# per round
	# 	y_r = return_rational(wrestler[:OC]).to_f * 
	# 		return_rational(wrestler[:OC_Ropes_Roll_Probability]).to_f *
	# 		r_prob * return_rational(wrestler[:Ropes_S_Roll_Probability]).to_f

	# 	r = x_r + y_r

	# 	oc + r
	end

	# # Takes SUB or TAG values and calculates probability 
	# # a card rolling that range.
	def sub_tag_probability(a)
	# 	num_range = 0

	# 	if a.size == 2
	# 		s = Range.new(a[0].to_i, a[1].to_i)

	# 		s.each { |x|
	# 			num_range += calculate_probability(x)
	# 		}
	# 	elsif a.size == 1
	# 		x = a[0].to_i
	# 		num_range += calculate_probability(x)
	# 	else
	# 		puts "Sub or Tag numbers are out of range."				
	# 	end

	# 	return num_range.to_f
	end






	# ===================
	# GENERATE STATISTICS
	# ===================

	def analyze(wrestler)

		calculate_total_card_rating(wrestler)

		# OLDER CODE

		# dc_points_without_reverse = 0
		# dc_reverse_roll_probability = 0


		# # Determine DC Points per roll
		# dc_hash = wrestler.points.select { |k,v| 
		# 	k.to_s.include?("DC")
		# }
		# dc_points_without_reverse = calculate_dc_points(dc_hash)

		# # Generate probabiity of OC roll in GC
		# gc_oc_roll_probability = return_rational(wrestler.points[:OC])

		# # Calculate temporary Variables
		# gc_dc_roll_probability = return_rational(wrestler.points[:DC])

		# # DC roll probability x Reverse roll probability
		# dc_reverse_roll_probability = calculate_reverse_roll_probability(wrestler.points, gc_dc_roll_probability)

		# dc_points_without_reverse = gc_dc_roll_probability * dc_points_without_reverse

		# # Probability of rolling P/A, DQ, XX or * in 
		# # Offiensive Card or Ropes Card.
		# dq_roll_probability_hash = calculate_specialty_dq_pa_subm_xx_probability(wrestler.points, '_dq')
		# pa_roll_probability_hash = calculate_specialty_dq_pa_subm_xx_probability(wrestler.points, '_pa')
		# submission_move_roll_probability_hash = calculate_specialty_dq_pa_subm_xx_probability(wrestler.points, '_sub')
		# xx_roll_probability_hash = calculate_specialty_dq_pa_subm_xx_probability(wrestler.points, '_xx')


		# # This is from the Specialty card only.
		# # Returns total (S) points / 6
		# average_specialty_points = calculate_specialty_points(wrestler.points)

		# # Seperate OC and Ropes cards and then calculate
		# # points per roll
		# oc_hash = wrestler.points.select { |k,v| k.to_s.include?('OC') && k.to_s.include?("_points")}
		# ropes_hash = wrestler.points.select { |k,v| k.to_s.include?('R') && k.to_s.include?("_points")}
		# # Takes the oc_hash and ropes_hash and calculates
		# # the points per roll (2d6 * card). These values 
		# # do not include Specialty rolls.
		# oc_points_per_roll = calculate_oc_and_ropes_points(oc_hash)

		# ropes_points_per_roll = calculate_oc_and_ropes_points(ropes_hash)

		# # Subtotals
		# oc_points_per_roll_subtotal = calculate_oc_points_per_roll_subtotal(oc_points_per_roll, gc_oc_roll_probability)
		# ropes_points_per_roll_subtotal = 
		# 	calculate_ropes_points_per_roll_subtotal(
		# 		ropes_points_per_roll, gc_oc_roll_probability, 
		# 		return_rational(wrestler.points[:Ropes_S_Roll_Probability]).to_f)

		# oc_and_ropes_specialty_probability = {
		# 	:OC => wrestler.points[:Specialty_Roll_Probability_in_OC], 
		# 	:R => wrestler.points[:Ropes_S_Roll_Probability]
		# }

		# specialty_points_per_roll = 
		# 	calculate_specialty_points_and_attributes_per_round(
		# 		average_specialty_points, 
		# 		gc_oc_roll_probability, 
		# 		oc_and_ropes_specialty_probability, 
		# 		return_rational(wrestler.points[:Ropes_S_Roll_Probability]).to_f)

		# # Calculate Total OC Points Per Roll
		# ropes_points_per_roll_total = 
		# 	specialty_points_per_roll[:ropes_points_per_roll] + 
		# 	ropes_points_per_roll_subtotal

		# oc_points_per_roll_total = 
		# 	ropes_points_per_roll_total + 
		# 	specialty_points_per_roll[:oc_points_per_roll] +
		# 	oc_points_per_roll_subtotal

		# dc_points_per_roll_total = 
		# 	calculate_dc_points_per_round_subtotal(
		# 		dc_points_without_reverse, 
		# 		dc_reverse_roll_probability, 
		# 		oc_points_per_roll_total)
	
		# 	# Calculate Total Card Values
		# 	card_points_per_round = oc_points_per_roll_total +
		# 		dc_points_per_roll_total
			
		# 	dq_probability_per_round = 
		# 		calculate_total_dq_pa_sub_xx_per_round("_dq", wrestler.points)

		# 	pa_probability_per_round = 
		# 		calculate_total_dq_pa_sub_xx_per_round("_pa", wrestler.points)

		# 	sub_probability_per_round = 
		# 		calculate_total_dq_pa_sub_xx_per_round("_sub", wrestler.points)

		# 	xx_probability_per_round = 
		# 		calculate_total_dq_pa_sub_xx_per_round("_xx", wrestler.points)

		# # Adds up the points_per_round with the probability
		# # of rolling P/A, Sub, XX, or DQ and then subtracts
		# # it by the probability of submission.
		# total_card_rating = card_points_per_round +
		# 	dq_probability_per_round + 
		# 	pa_probability_per_round + 
		# 	sub_probability_per_round + 
		# 	xx_probability_per_round +
		# 	wrestler.values[:PriorityS].to_f -
		# 	sub_tag_probability(wrestler.values[:Sub])


		# Revise Wrestler Priority Numbers


		# Add values to wrestler's hash
		@statistics[:oc_probability] = wrestler.points[:oc_probability]
		@statistics[:dc_probability] = wrestler.points[:DC]
		@statistics[:tt_probability] = wrestler.points[:GC_TT_Roll]
		# @statistics[:oc_card_points_per_round] = oc_points_per_roll_total
		# @statistics[:dc_card_points_per_round] = dc_points_per_roll_total
		# @statistics[:total_card_points_per_round] = card_points_per_round
		# @statistics[:dq_probability_per_round] = dq_probability_per_round
		# @statistics[:pa_probability_per_round] = pa_probability_per_round
		# @statistics[:sub_probability_per_round] = sub_probability_per_round
		# @statistics[:xx_probability_per_round] = xx_probability_per_round
		# @statistics[:submission_loss_probabilty] = sub_tag_probability(wrestler.values[:Sub])
		# @statistics[:tag_team_save_probabilty] = sub_tag_probability(wrestler.values[:Tag])
		# @statistics[:card_rating] = total_card_rating
		
		# Check for Problems in :Set attribute of hash.
		if wrestler.values[:Set] == nil
			wrestler.values[:Set] = 'Special'
		end

		return @statistics
	end
end
