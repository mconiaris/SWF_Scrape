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

	# TODO: Set up attr_reader and writers (=) for variables
	# TODO: Use getters to add values to hash directly
	# Takes in Wrestler card information and calculates
	# TODO: Consider a custom matcher for complicated math problems: https://github.com/dchelimsky/rspec/wiki/Custom-Matchers
	# the probablities and points totals.
	def move_points(hash)
		points = Hash.new

		gc_hash = hash.select { |k,v| k.to_s.include?('GC') }
		oc_hash = gc_hash.select { |k,v| v.include?('OC') }

		# Calculate OC count to calculate probablity.
		points[:OC] = prob_points(oc_hash)
		
		# Create Symbols for Points
		points[:DC02_points] = 0
 		points[:DC03_points] = 0
 		points[:DC04_points] = 0
 		points[:DC05_points] = 0
 		points[:DC06_points] = 0
 		points[:DC07_points] = 0
 		points[:DC08_points] = 0
 		points[:DC09_points] = 0
 		points[:DC10_points] = 0
 		points[:DC11_points] = 0
 		points[:DC12_points] = 0
		
		points[:Reverse] = 0
		points[:Specialty_Roll_Probability_in_OC] = 0
 		
 		points[:S1_points] = 0
 		points[:S2_points] = 0
 		points[:S3_points] = 0
 		points[:S4_points] = 0
 		points[:S5_points] = 0
 		points[:S6_points] = 0

 		points[:OC02_points] = 0
 		points[:OC03_points] = 0
 		points[:OC04_points] = 0
 		points[:OC05_points] = 0
 		points[:OC06_points] = 0
 		points[:OC07_points] = 0
 		points[:OC08_points] = 0
 		points[:OC09_points] = 0
 		points[:OC10_points] = 0
 		points[:OC11_points] = 0
 		points[:OC12_points] = 0

 		points[:OC_Ropes_Roll_Probability] = 0
 		points[:Ropes_S_Roll_Probability] = 0

 		points[:RO02_points] = 0
 		points[:RO03_points] = 0
 		points[:RO04_points] = 0
 		points[:RO05_points] = 0
 		points[:RO06_points] = 0
 		points[:RO07_points] = 0
 		points[:RO08_points] = 0
 		points[:RO09_points] = 0
 		points[:RO10_points] = 0
 		points[:RO11_points] = 0
 		points[:RO12_points] = 0


		# Determine Points for DC Rolls
		dc_hash = hash.select { |k,v| k.to_s.include?('DC') }
		dc_hash.each { | k,v|
			if v == "A"
				points["#{k}_points".to_sym] = 2
			elsif v == "C"
				points["#{k}_points".to_sym] = 4
			else
				points["#{k}_points".to_sym] = 0
			end
		}

		# Calculate Reverse Roll in DC
		reverse_roll = 0
		r_hash = hash.select { |k,v| v.include?('Reverse') }
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

		return points
	end

	def prob_points(move)
		# Calculate OC count to calculate probablity.
		count = 0
		move.each_key { |k|
			if k.to_s.include?('02') || k.to_s.include?('12')
				count = count + 1
			elsif k.to_s.include?('03') || k.to_s.include?('11')
				count = count +2
			elsif k.to_s.include?('04') || k.to_s.include?('10')
				count = count +3
			elsif k.to_s.include?('05') || k.to_s.include?('09')
				count = count +4
			elsif k.to_s.include?('06') || k.to_s.include?('08')
				count = count +5
			else k.to_s.include?('07')
				count = count +6
			end
		}

		return count
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
			binding.pry
			return m[m.length-2].to_i
		elsif m.last.to_i != 0
			return m.last.to_i
		else
			return "Error"
		end
	end










	def analyze(wrestler)

		gc_oc_roll_probability = 0
		gc_dc_roll_probability = 0

		dc_points_without_reverse = 0
		dc_reverse_roll_probability = 0

		wrestler.values.each {
			|key, value| k = key.to_s
				if k[0..1] == 'GC'
					# puts "#{key}: #{value}"
					gc_oc_roll_probability += calculate_gc_oc_roll_probability(key, value.strip)
				elsif k[0..1] == 'DC'
					# puts "#{key}: #{value}"
					dc_points_without_reverse += calculate_dc_points(key, value.strip)
				elsif k[0] == "S" && k[1] != "p" && k[1] != 'e'
					# puts "#{key}: #{value}"
					# s_stats_array.push(analyze_s(key, value))
				else
					# puts "Else statement values: #{key}: #{value}"
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


	def symbol_to_integer(key)
		key[-2..-1].to_i
	end

	# TODO: Refactor this.
	# This returns the rational number (fraction) of a
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
	

	# ============
	# GENERAL CARD
	# ============

	# Takes in wrestler hash and calculates the
	# probability of an OC roll.
	def calculate_gc_oc_roll_probability(key, value)

		oc_roll_probability = 0

		# Converts symbol key into a string so it can be 
		# passed to the calculate_probabily method.
		k = symbol_to_integer(key)

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
			|k| prob += calculate_probability(symbol_to_integer(k))
		}

		return prob
	end


	# ==============
	# DEFENSIVE CARD
	# ==============
	# Takes in wrestler card hash and searches for OC/TT
	# rolls and then calculates their probability.
	# TODO: Modify code so that REVERSE can be isolated
	# no matter the case. Also make rspec test.
	def calculate_reverse_roll_probability(wrestler_hash, gc_dc_roll_probability)
		h = wrestler_hash.select { |k,v| v == 'Reverse' }
		prob = 0

		h.each_key {
			|k| prob += calculate_probability(symbol_to_integer(k))
		}

		return prob * gc_dc_roll_probability
	end

	# Tabulates the A, B & C return values and multiplies
	# it by the probability of rolling them.
	def calculate_dc_points(k,v)

		case v
		when 'A'
			return DC_A * calculate_probability(symbol_to_integer(k)).to_f
		when 'B'
			# puts result
			return 0
		when 'C'
			# puts result
			return DC_C * calculate_probability(symbol_to_integer(k)).to_f
		when "REVERSE"
			# puts result
			return 0
		when "Reverse"
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