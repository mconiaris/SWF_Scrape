class Wrestler

	attr_accessor :points
	attr_accessor :statistics
	attr_accessor :values

	def initialize(card)
		@values = card
	end

# TODO: Fix output for csv when wrestler has one value for Sub or Tag save.

	# Takes Wrestler object statistics and prints them
	# out to a CSV file.
	def wrestler_output(wrestler)

		puts "Name: #{wrestler.values[:name]}"
		puts "Set: #{wrestler.values[:Set]}"
		puts "Singles Priority: #{wrestler.values[:PriorityS]}"
		puts "Tag Team Priority: #{wrestler.values[:PriorityT]}"
		puts "TT Probability: #{wrestler.statistics[:tt_probability]}"
		puts "Card Rating: #{wrestler.statistics[:total_card_rating]}"
		puts "OC Probability: #{wrestler.statistics[:oc_probability]}"
		puts "Total Points-Per-Round: #{wrestler.statistics[:total_card_points_per_round]}"
		puts "DQ Probability-Per-Round: #{wrestler.statistics[:dq_probability_per_round]}"
		puts "P/A Probability-Per-Round: #{wrestler.statistics[:pa_probability_per_round]}"
		puts "Submission Roll Probability-Per-Round: #{wrestler.statistics[:sub_probability_per_round]}"
		puts "XX Roll Probability-Per-Round: #{wrestler.statistics[:xx_probability_per_round]}"
		puts "Submission Loss Probability: #{wrestler.points[:Sub_prob]}"
		puts "Tag Team Save Probability: #{wrestler.points[:Tag_prob]}"
		puts "\n"

		tt_probability = "%.1f" % (wrestler.statistics[:tt_probability] * 100) + "%"
		card_rating = "%.1f" % wrestler.statistics[:total_card_rating]
		oc_probability = "%.1f" % (wrestler.statistics[:oc_probability] * 100) + "%"
		total_card_points_per_round = "%.3f" % wrestler.statistics[:total_card_points_per_round]
		dq_probability_per_round = "%.1f" % (wrestler.statistics[:dq_probability_per_round] * 100) + "%"
		pa_probability_per_round = "%.1f" % (wrestler.statistics[:pa_probability_per_round] * 100) + "%"
		sub_probability_per_round = "%.1f" % (wrestler.statistics[:sub_probability_per_round] * 100) + "%"
		xx_probability_per_round = "%.1f" % (wrestler.statistics[:xx_probability_per_round] * 100) + "%"
		sub_prob = "%.1f" % (wrestler.points[:Sub_prob] * 100) + "%"
		tag_prob = "%.1f" % (wrestler.points[:Tag_prob] * 100) + "%"

		f = File.new('files/results.csv', 'a')
		f.write("#{wrestler.values[:name]},#{wrestler.values[:Set]}, #{wrestler.values[:PriorityS]}, #{wrestler.values[:PriorityT]}, #{tt_probability}, #{card_rating}, #{oc_probability}, #{total_card_points_per_round}, #{dq_probability_per_round}, #{pa_probability_per_round}, #{sub_probability_per_round}, #{xx_probability_per_round}, #{sub_prob}, #{tag_prob}, \n")
		f.close
	end

	# Method to seed database for web app.
	def wrestler_raw_values_output
		tt_probability = "%.1f" % (self.statistics[:tt_probability] * 100) + "%"
		card_rating = "%.1f" % self.statistics[:total_card_rating]
		oc_probability = "%.1f" % (self.statistics[:oc_probability] * 100) + "%"
		total_card_points_per_round = "%.3f" % self.statistics[:total_card_points_per_round]
		dq_probability_per_round = "%.1f" % (self.statistics[:dq_probability_per_round] * 100) + "%"
		pa_probability_per_round = "%.1f" % (self.statistics[:pa_probability_per_round] * 100) + "%"
		sub_probability_per_round = "%.1f" % (self.statistics[:sub_probability_per_round] * 100) + "%"
		xx_probability_per_round = "%.1f" % (self.statistics[:xx_probability_per_round] * 100) + "%"
		sub_prob = "%.1f" % (self.points[:Sub_prob] * 100) + "%"
		tag_prob = "%.1f" % (self.points[:Tag_prob] * 100) + "%"

		f = File.new('files/raw_results.csv', 'a')
		f.write("#{self.values[:Set]},")
		self.values.each { |k, v|
			f.write(v, ",") 
		}
		f.write("#{tt_probability}, #{card_rating}, #{oc_probability}, #{total_card_points_per_round}, #{dq_probability_per_round}, #{pa_probability_per_round}, #{sub_probability_per_round}, #{xx_probability_per_round}, #{sub_prob}, #{tag_prob}, #{wrestler.values[:Sub][0]}, #{wrestler.values[:Sub][1]}, #{wrestler.values[:Tag][0]}, #{wrestler.values[:Tag][1]}\n")
		f.close
	end

	def wrestler_values_output
		f = File.new("files/output/#{self.values[:name]}_#{self.values[:Set]}_values.csv", 'a')
		self.values.each { |k, v|
			f.write(k, ",", v, "\n")
		}
		f.write("Sub:, #{self.values[:Sub][0]}-#{self.values[:Sub][1]}\n")
		f.write("Tag:, #{self.values[:Tag][0]}-#{self.values[:Tag][1]}\n")
		f.write("Priority:, #{self.values[:PriorityS]}/#{self.values[:PriorityT]}\n")
	end

	def wrestler_points_output
		f = File.new("files/output/#{self.values[:name]}_#{self.values[:Set]}_points.csv", 'a')
		f.write("\nName:, #{self.values[:name]}\n")
		f.write("GC-OC Roll (x/36):, #{self.points[:OC_enumerator]}\n")
		f.write("GC-TT Roll (x/36):, #{self.points[:GC_TT_Enumerator]}\n")
		f.write("DC02_points:, #{self.points[:DC02_points]}\n")
 		f.write("DC03_points:, #{self.points[:DC03_points]}\n")
 		f.write("DC04_points:, #{self.points[:DC04_points]}\n")
 		f.write("DC05_points:, #{self.points[:DC05_points]}\n")
 		f.write("DC06_points:, #{self.points[:DC06_points]}\n")
 		f.write("DC07_points:, #{self.points[:DC07_points]}\n")
 		f.write("DC08_points:, #{self.points[:DC08_points]}\n")
 		f.write("DC09_points:, #{self.points[:DC09_points]}\n")
 		f.write("DC10_points:, #{self.points[:DC10_points]}\n")
 		f.write("DC11_points:, #{self.points[:DC11_points]}\n")
 		f.write("DC12_points:, #{self.points[:DC12_points]}\n")
 		f.write("Reverse (x/36), #{self.points[:Reverse]}\n")
		f.write("Specialty Roll Probability in OC (x/36), #{self.points[:Specialty_Roll_Enumerator_in_OC]}\n")
		f.write("Specialty-1-Points, #{self.points[:S1_points]}\n")
		f.write("Specialty-2-Points, #{self.points[:S2_points]}\n")
		f.write("Specialty-3-Points, #{self.points[:S3_points]}\n")
		f.write("Specialty-4-Points, #{self.points[:S4_points]}\n")
		f.write("Specialty-5-Points, #{self.points[:S5_points]}\n")
		f.write("Specialty-6-Points, #{self.points[:S6_points]}\n")
		f.write("Specialty Roll Probability-DQ (x/6), #{self.points[:s_roll_prob_dq]}\n")
		f.write("Specialty Roll Probability-P/A (x/6), #{self.points[:s_roll_prob_pa]}\n")
		f.write("Specialty Roll Probability-* (x/6), #{self.points[:s_roll_prob_sub]}\n")
		f.write("Specialty Roll Probability-XX (x/6), #{self.points[:s_roll_prob_xx]}\n")
		f.write("OC-2-Points, #{self.points[:OC02_points]}\n")
		f.write("OC-3-Points, #{self.points[:OC03_points]}\n")
		f.write("OC-4-Points, #{self.points[:OC04_points]}\n")
		f.write("OC-5-Points, #{self.points[:OC05_points]}\n")
		f.write("OC-6-Points, #{self.points[:OC06_points]}\n")
		f.write("OC-7-Points, #{self.points[:OC07_points]}\n")
		f.write("OC-8-Points, #{self.points[:OC08_points]}\n")
		f.write("OC-9-Points, #{self.points[:OC09_points]}\n")
		f.write("OC-10-Points, #{self.points[:OC10_points]}\n")
		f.write("OC-11-Points, #{self.points[:OC11_points]}\n")
		f.write("OC-12-Points, #{self.points[:OC12_points]}\n")
		f.write("OC-2-DQ (0 or 1), #{self.points[:OC02_dq]}\n")
		f.write("OC-3-DQ (0 or 1), #{self.points[:OC03_dq]}\n")
		f.write("OC-4-DQ (0 or 1), #{self.points[:OC04_dq]}\n")
		f.write("OC-5-DQ (0 or 1), #{self.points[:OC05_dq]}\n")
		f.write("OC-6-DQ (0 or 1), #{self.points[:OC06_dq]}\n")
		f.write("OC-7-DQ (0 or 1), #{self.points[:OC07_dq]}\n")
		f.write("OC-8-DQ (0 or 1), #{self.points[:OC08_dq]}\n")
		f.write("OC-9-DQ (0 or 1), #{self.points[:OC09_dq]}\n")
		f.write("OC-10-DQ (0 or 1), #{self.points[:OC10_dq]}\n")
		f.write("OC-11-DQ (0 or 1), #{self.points[:OC11_dq]}\n")
		f.write("OC-12-DQ (0 or 1), #{self.points[:OC12_dq]}\n")
		f.write("OC-2-P/A (0 or 1), #{self.points[:OC02_pa]}\n")
		f.write("OC-3-P/A (0 or 1), #{self.points[:OC03_pa]}\n")
		f.write("OC-4-P/A (0 or 1), #{self.points[:OC04_pa]}\n")
		f.write("OC-5-P/A (0 or 1), #{self.points[:OC05_pa]}\n")
		f.write("OC-6-P/A (0 or 1), #{self.points[:OC06_pa]}\n")
		f.write("OC-7-P/A (0 or 1), #{self.points[:OC07_pa]}\n")
		f.write("OC-8-P/A (0 or 1), #{self.points[:OC08_pa]}\n")
		f.write("OC-9-P/A (0 or 1), #{self.points[:OC09_pa]}\n")
		f.write("OC-10-P/A (0 or 1), #{self.points[:OC10_pa]}\n")
		f.write("OC-11-P/A (0 or 1), #{self.points[:OC11_pa]}\n")
		f.write("OC-12-P/A (0 or 1), #{self.points[:OC12_pa]}\n")
		f.write("OC-2-* (0 or 1), #{self.points[:OC02_sub]}\n")
		f.write("OC-3-* (0 or 1), #{self.points[:OC03_sub]}\n")
		f.write("OC-4-* (0 or 1), #{self.points[:OC04_sub]}\n")
		f.write("OC-5-* (0 or 1), #{self.points[:OC05_sub]}\n")
		f.write("OC-6-* (0 or 1), #{self.points[:OC06_sub]}\n")
		f.write("OC-7-* (0 or 1), #{self.points[:OC07_sub]}\n")
		f.write("OC-8-* (0 or 1), #{self.points[:OC08_sub]}\n")
		f.write("OC-9-* (0 or 1), #{self.points[:OC09_sub]}\n")
		f.write("OC-10-* (0 or 1), #{self.points[:OC10_sub]}\n")
		f.write("OC-11-* (0 or 1), #{self.points[:OC11_sub]}\n")
		f.write("OC-12-* (0 or 1), #{self.points[:OC12_sub]}\n")
		f.write("OC-2-(XX) (0 or 1), #{self.points[:OC02_xx]}\n")
		f.write("OC-3-(XX) (0 or 1), #{self.points[:OC03_xx]}\n")
		f.write("OC-4-(XX) (0 or 1), #{self.points[:OC04_xx]}\n")
		f.write("OC-5-(XX) (0 or 1), #{self.points[:OC05_xx]}\n")
		f.write("OC-6-(XX) (0 or 1), #{self.points[:OC06_xx]}\n")
		f.write("OC-7-(XX) (0 or 1), #{self.points[:OC07_xx]}\n")
		f.write("OC-8-(XX) (0 or 1), #{self.points[:OC08_xx]}\n")
		f.write("OC-9-(XX) (0 or 1), #{self.points[:OC09_xx]}\n")
		f.write("OC-10-(XX) (0 or 1), #{self.points[:OC10_xx]}\n")
		f.write("OC-11-(XX) (0 or 1), #{self.points[:OC11_xx]}\n")
		f.write("OC-12-(XX) (0 or 1), #{self.points[:OC12_xx]}\n")
		f.write("OC Ropes Roll Probability (x/3), #{self.points[:OC_Ropes_Roll_Probability]}\n")
		f.write("Ropes (S) Roll Probability (x/36), #{self.points[:Ropes_S_Roll_Probability]}\n")
		f.write("R-2-Points, #{self.points[:RO02_points]}\n")
		f.write("R-3-Points, #{self.points[:RO03_points]}\n")
		f.write("R-4-Points, #{self.points[:RO04_points]}\n")
		f.write("R-5-Points, #{self.points[:RO05_points]}\n")
		f.write("R-6-Points, #{self.points[:RO06_points]}\n")
		f.write("R-7-Points, #{self.points[:RO07_points]}\n")
		f.write("R-8-Points, #{self.points[:RO08_points]}\n")
		f.write("R-9-Points, #{self.points[:RO09_points]}\n")
		f.write("R-10-Points, #{self.points[:RO10_points]}\n")
		f.write("R-11-Points, #{self.points[:RO11_points]}\n")
		f.write("R-12-Points, #{self.points[:RO12_points]}\n")
		f.write("R-2-DQ (0 or 1), #{self.points[:RO02_dq]}\n")
		f.write("R-3-DQ (0 or 1), #{self.points[:RO03_dq]}\n")
		f.write("R-4-DQ (0 or 1), #{self.points[:RO04_dq]}\n")
		f.write("R-5-DQ (0 or 1), #{self.points[:RO05_dq]}\n")
		f.write("R-6-DQ (0 or 1), #{self.points[:RO06_dq]}\n")
		f.write("R-7-DQ (0 or 1), #{self.points[:RO07_dq]}\n")
		f.write("R-8-DQ (0 or 1), #{self.points[:RO08_dq]}\n")
		f.write("R-9-DQ (0 or 1), #{self.points[:RO09_dq]}\n")
		f.write("R-10-DQ (0 or 1), #{self.points[:RO10_dq]}\n")
		f.write("R-11-DQ (0 or 1), #{self.points[:RO11_dq]}\n")
		f.write("R-12-DQ (0 or 1), #{self.points[:RO12_dq]}\n")
		f.write("R-2-P/A (0 or 1), #{self.points[:RO02_pa]}\n")
		f.write("R-3-P/A (0 or 1), #{self.points[:RO03_pa]}\n")
		f.write("R-4-P/A (0 or 1), #{self.points[:RO04_pa]}\n")
		f.write("R-5-P/A (0 or 1), #{self.points[:RO05_pa]}\n")
		f.write("R-6-P/A (0 or 1), #{self.points[:RO06_pa]}\n")
		f.write("R-7-P/A (0 or 1), #{self.points[:RO07_pa]}\n")
		f.write("R-8-P/A (0 or 1), #{self.points[:RO08_pa]}\n")
		f.write("R-9-P/A (0 or 1), #{self.points[:RO09_pa]}\n")
		f.write("R-10-P/A (0 or 1), #{self.points[:RO10_pa]}\n")
		f.write("R-11-P/A (0 or 1), #{self.points[:RO11_pa]}\n")
		f.write("R-12-P/A (0 or 1), #{self.points[:RO12_pa]}\n")
		f.write("R-2-* (0 or 1), #{self.points[:RO02_sub]}\n")
		f.write("R-3-* (0 or 1), #{self.points[:RO03_sub]}\n")
		f.write("R-4-* (0 or 1), #{self.points[:RO04_sub]}\n")
		f.write("R-5-* (0 or 1), #{self.points[:RO05_sub]}\n")
		f.write("R-6-* (0 or 1), #{self.points[:RO06_sub]}\n")
		f.write("R-7-* (0 or 1), #{self.points[:RO07_sub]}\n")
		f.write("R-8-* (0 or 1), #{self.points[:RO08_sub]}\n")
		f.write("R-9-* (0 or 1), #{self.points[:RO09_sub]}\n")
		f.write("R-10-* (0 or 1), #{self.points[:RO10_sub]}\n")
		f.write("R-11-* (0 or 1), #{self.points[:RO11_sub]}\n")
		f.write("R-12-* (0 or 1), #{self.points[:RO12_sub]}\n")
		f.write("R-2-(XX) (0 or 1), #{self.points[:RO02_xx]}\n")
		f.write("R-3-(XX) (0 or 1), #{self.points[:RO03_xx]}\n")
		f.write("R-4-(XX) (0 or 1), #{self.points[:RO04_xx]}\n")
		f.write("R-5-(XX) (0 or 1), #{self.points[:RO05_xx]}\n")
		f.write("R-6-(XX) (0 or 1), #{self.points[:RO06_xx]}\n")
		f.write("R-7-(XX) (0 or 1), #{self.points[:RO07_xx]}\n")
		f.write("R-8-(XX) (0 or 1), #{self.points[:RO08_xx]}\n")
		f.write("R-9-(XX) (0 or 1), #{self.points[:RO09_xx]}\n")
		f.write("R-10-(XX) (0 or 1), #{self.points[:RO10_xx]}\n")
		f.write("R-11-(XX) (0 or 1), #{self.points[:RO11_xx]}\n")
		f.write("R-12-(XX) (0 or 1), #{self.points[:RO12_xx]}\n")
		f.write("PriorityS:, #{self.values[:PriorityS]}\n")
		f.write("PRIORITY-TT, #{self.values[:PriorityT]}\n")
		f.write("SUBMISSION (x/36):, #{self.points[:sub_numerator]}\n")
		f.write("TAG TEAM SAVE (x/36):, #{self.points[:tag_save_numerator]}\n")
	
	end

	def wrestler_hash_output
		wrestler_hash_output = self.values

		wrestler_hash_output["name"] = wrestler_hash_output.delete :name
		wrestler_hash_output["set"] = wrestler_hash_output.delete :Set

		wrestler_hash_output["gc02"] = wrestler_hash_output.delete :GC02
		wrestler_hash_output["gc03"] = wrestler_hash_output.delete :GC03
		wrestler_hash_output["gc04"] = wrestler_hash_output.delete :GC04
		wrestler_hash_output["gc05"] = wrestler_hash_output.delete :GC05
		wrestler_hash_output["gc06"] = wrestler_hash_output.delete :GC06
		wrestler_hash_output["gc07"] = wrestler_hash_output.delete :GC07
		wrestler_hash_output["gc08"] = wrestler_hash_output.delete :GC08
		wrestler_hash_output["gc09"] = wrestler_hash_output.delete :GC09
		wrestler_hash_output["gc10"] = wrestler_hash_output.delete :GC10
		wrestler_hash_output["gc11"] = wrestler_hash_output.delete :GC11
		wrestler_hash_output["gc12"] = wrestler_hash_output.delete :GC12

		wrestler_hash_output["dc02"] = wrestler_hash_output.delete :DC02
		wrestler_hash_output["dc03"] = wrestler_hash_output.delete :DC03
		wrestler_hash_output["dc04"] = wrestler_hash_output.delete :DC04
		wrestler_hash_output["dc05"] = wrestler_hash_output.delete :DC05
		wrestler_hash_output["dc06"] = wrestler_hash_output.delete :DC06
		wrestler_hash_output["dc07"] = wrestler_hash_output.delete :DC07
		wrestler_hash_output["dc08"] = wrestler_hash_output.delete :DC08
		wrestler_hash_output["dc09"] = wrestler_hash_output.delete :DC09
		wrestler_hash_output["dc10"] = wrestler_hash_output.delete :DC10
		wrestler_hash_output["dc11"] = wrestler_hash_output.delete :DC11
		wrestler_hash_output["dc12"] = wrestler_hash_output.delete :DC12

		wrestler_hash_output["specialty"] = wrestler_hash_output.delete :Specialty

		wrestler_hash_output["s1"] = wrestler_hash_output.delete :S1
		wrestler_hash_output["s2"] = wrestler_hash_output.delete :S2
		wrestler_hash_output["s3"] = wrestler_hash_output.delete :S3
		wrestler_hash_output["s4"] = wrestler_hash_output.delete :S4
		wrestler_hash_output["s5"] = wrestler_hash_output.delete :S5
		wrestler_hash_output["s6"] = wrestler_hash_output.delete :S6

		wrestler_hash_output["subx"] = wrestler_hash_output[:Sub][0]
		wrestler_hash_output["suby"] = wrestler_hash_output[:Sub][1]
		wrestler_hash_output["tagx"] = wrestler_hash_output[:Sub][0]
		wrestler_hash_output["tagy"] = wrestler_hash_output[:Sub][1]

		wrestler_hash_output.delete :Sub
		wrestler_hash_output.delete :Tag

		wrestler_hash_output["prioritys"] = wrestler_hash_output.delete :PriorityS
		wrestler_hash_output["priorityt"] = wrestler_hash_output.delete :PriorityT

		wrestler_hash_output["oc02"] = wrestler_hash_output.delete :OC02
		wrestler_hash_output["oc03"] = wrestler_hash_output.delete :OC03
		wrestler_hash_output["oc04"] = wrestler_hash_output.delete :OC04
		wrestler_hash_output["oc05"] = wrestler_hash_output.delete :OC05
		wrestler_hash_output["oc06"] = wrestler_hash_output.delete :OC06
		wrestler_hash_output["oc07"] = wrestler_hash_output.delete :OC07
		wrestler_hash_output["oc08"] = wrestler_hash_output.delete :OC08
		wrestler_hash_output["oc09"] = wrestler_hash_output.delete :OC09
		wrestler_hash_output["oc10"] = wrestler_hash_output.delete :OC10
		wrestler_hash_output["oc11"] = wrestler_hash_output.delete :OC11
		wrestler_hash_output["oc12"] = wrestler_hash_output.delete :OC12

		wrestler_hash_output["ro02"] = wrestler_hash_output.delete :RO02
		wrestler_hash_output["ro03"] = wrestler_hash_output.delete :RO03
		wrestler_hash_output["ro04"] = wrestler_hash_output.delete :RO04
		wrestler_hash_output["ro05"] = wrestler_hash_output.delete :RO05
		wrestler_hash_output["ro06"] = wrestler_hash_output.delete :RO06
		wrestler_hash_output["ro07"] = wrestler_hash_output.delete :RO07
		wrestler_hash_output["ro08"] = wrestler_hash_output.delete :RO08
		wrestler_hash_output["ro09"] = wrestler_hash_output.delete :RO09
		wrestler_hash_output["ro10"] = wrestler_hash_output.delete :RO10
		wrestler_hash_output["ro11"] = wrestler_hash_output.delete :RO11
		wrestler_hash_output["ro12"] = wrestler_hash_output.delete :RO12

		f = File.new("files/output/#{wrestler_hash_output["name"]}_#{wrestler_hash_output["set"]}_hash.txt", 'a')

		f.write("{")
		wrestler_hash_output.each { |k,v|
			f.write("\"#{k}\"=>\"#{v}\", ")
		}
		f.write("template: nil}")

		f.write("\n\n")
	end

end