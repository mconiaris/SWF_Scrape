class Wrestler

	attr_accessor :points
	attr_accessor :statistics
	attr_accessor :values

	def initialize(card)
		@values = card
	end



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

	def wrestler_values_output(wrestler)
		f = File.new("files/output/#{wrestler.values[:name]}_values.csv", 'a')
		wrestler.values.each { |k, v|
			f.write(k, ",", v, "\n")  }
		f.write("Sub:, #{wrestler.values[:Sub][0]}-#{wrestler.values[:Sub][1]}\n")
		f.write("Tag:, #{wrestler.values[:Tag][0]}-#{wrestler.values[:Tag][1]}\n")
		f.write("Priority:, #{wrestler.values[:PriorityS]}/#{wrestler.values[:PriorityT]}\n")
	end

	def wrestler_points_output(wrestler)
		f = File.new("files/output/#{wrestler.values[:name]}_points.csv", 'a')
		f.write("\nName:, #{wrestler.values[:name]}\n")
		f.write("GC-OC Roll (x/36):, #{wrestler.points[:OC_enumerator]}\n")
		f.write("GC-TT Roll (x/36):, #{wrestler.points[:GC_TT_Enumerator]}\n")
		f.write("DC02_points:, #{wrestler.points[:DC02_points]}\n")
 		f.write("DC03_points:, #{wrestler.points[:DC03_points]}\n")
 		f.write("DC04_points:, #{wrestler.points[:DC04_points]}\n")
 		f.write("DC05_points:, #{wrestler.points[:DC05_points]}\n")
 		f.write("DC06_points:, #{wrestler.points[:DC06_points]}\n")
 		f.write("DC07_points:, #{wrestler.points[:DC07_points]}\n")
 		f.write("DC08_points:, #{wrestler.points[:DC08_points]}\n")
 		f.write("DC09_points:, #{wrestler.points[:DC09_points]}\n")
 		f.write("DC10_points:, #{wrestler.points[:DC10_points]}\n")
 		f.write("DC11_points:, #{wrestler.points[:DC11_points]}\n")
 		f.write("DC12_points:, #{wrestler.points[:DC12_points]}\n")
 		f.write("Reverse (x/36), #{wrestler.points[:Reverse]}\n")
		f.write("Specialty Roll Probability in OC (x/36), #{wrestler.points[:Specialty_Roll_Enumerator_in_OC]}\n")
		f.write("Specialty-1-Points, #{wrestler.points[:S1_points]}\n")
		f.write("Specialty-2-Points, #{wrestler.points[:S2_points]}\n")
		f.write("Specialty-3-Points, #{wrestler.points[:S3_points]}\n")
		f.write("Specialty-4-Points, #{wrestler.points[:S4_points]}\n")
		f.write("Specialty-5-Points, #{wrestler.points[:S5_points]}\n")
		f.write("Specialty-6-Points, #{wrestler.points[:S6_points]}\n")
		f.write("Specialty Roll Probability-DQ (x/6), #{wrestler.points[:s_roll_prob_dq]}\n")
		f.write("Specialty Roll Probability-P/A (x/6), #{wrestler.points[:s_roll_prob_pa]}\n")
		f.write("Specialty Roll Probability-* (x/6), #{wrestler.points[:s_roll_prob_sub]}\n")
		f.write("Specialty Roll Probability-XX (x/6), #{wrestler.points[:s_roll_prob_xx]}\n")
		f.write("OC-2-Points, #{wrestler.points[:OC02_points]}\n")
		f.write("OC-3-Points, #{wrestler.points[:OC03_points]}\n")
		f.write("OC-4-Points, #{wrestler.points[:OC04_points]}\n")
		f.write("OC-5-Points, #{wrestler.points[:OC05_points]}\n")
		f.write("OC-6-Points, #{wrestler.points[:OC06_points]}\n")
		f.write("OC-7-Points, #{wrestler.points[:OC07_points]}\n")
		f.write("OC-8-Points, #{wrestler.points[:OC08_points]}\n")
		f.write("OC-9-Points, #{wrestler.points[:OC09_points]}\n")
		f.write("OC-10-Points, #{wrestler.points[:OC10_points]}\n")
		f.write("OC-11-Points, #{wrestler.points[:OC11_points]}\n")
		f.write("OC-12-Points, #{wrestler.points[:OC12_points]}\n")
		f.write("OC-2-DQ (0 or 1), #{wrestler.points[:OC02_dq]}\n")
		f.write("OC-3-DQ (0 or 1), #{wrestler.points[:OC03_dq]}\n")
		f.write("OC-4-DQ (0 or 1), #{wrestler.points[:OC04_dq]}\n")
		f.write("OC-5-DQ (0 or 1), #{wrestler.points[:OC05_dq]}\n")
		f.write("OC-6-DQ (0 or 1), #{wrestler.points[:OC06_dq]}\n")
		f.write("OC-7-DQ (0 or 1), #{wrestler.points[:OC07_dq]}\n")
		f.write("OC-8-DQ (0 or 1), #{wrestler.points[:OC08_dq]}\n")
		f.write("OC-9-DQ (0 or 1), #{wrestler.points[:OC09_dq]}\n")
		f.write("OC-10-DQ (0 or 1), #{wrestler.points[:OC10_dq]}\n")
		f.write("OC-11-DQ (0 or 1), #{wrestler.points[:OC11_dq]}\n")
		f.write("OC-12-DQ (0 or 1), #{wrestler.points[:OC12_dq]}\n")
		f.write("OC-2-P/A (0 or 1), #{wrestler.points[:OC02_pa]}\n")
		f.write("OC-3-P/A (0 or 1), #{wrestler.points[:OC03_pa]}\n")
		f.write("OC-4-P/A (0 or 1), #{wrestler.points[:OC04_pa]}\n")
		f.write("OC-5-P/A (0 or 1), #{wrestler.points[:OC05_pa]}\n")
		f.write("OC-6-P/A (0 or 1), #{wrestler.points[:OC06_pa]}\n")
		f.write("OC-7-P/A (0 or 1), #{wrestler.points[:OC07_pa]}\n")
		f.write("OC-8-P/A (0 or 1), #{wrestler.points[:OC08_pa]}\n")
		f.write("OC-9-P/A (0 or 1), #{wrestler.points[:OC09_pa]}\n")
		f.write("OC-10-P/A (0 or 1), #{wrestler.points[:OC10_pa]}\n")
		f.write("OC-11-P/A (0 or 1), #{wrestler.points[:OC11_pa]}\n")
		f.write("OC-12-P/A (0 or 1), #{wrestler.points[:OC12_pa]}\n")
		f.write("OC-2-* (0 or 1), #{wrestler.points[:OC02_sub]}\n")
		f.write("OC-3-* (0 or 1), #{wrestler.points[:OC03_sub]}\n")
		f.write("OC-4-* (0 or 1), #{wrestler.points[:OC04_sub]}\n")
		f.write("OC-5-* (0 or 1), #{wrestler.points[:OC05_sub]}\n")
		f.write("OC-6-* (0 or 1), #{wrestler.points[:OC06_sub]}\n")
		f.write("OC-7-* (0 or 1), #{wrestler.points[:OC07_sub]}\n")
		f.write("OC-8-* (0 or 1), #{wrestler.points[:OC08_sub]}\n")
		f.write("OC-9-* (0 or 1), #{wrestler.points[:OC09_sub]}\n")
		f.write("OC-10-* (0 or 1), #{wrestler.points[:OC10_sub]}\n")
		f.write("OC-11-* (0 or 1), #{wrestler.points[:OC11_sub]}\n")
		f.write("OC-12-* (0 or 1), #{wrestler.points[:OC12_sub]}\n")
		f.write("OC-2-(XX) (0 or 1), #{wrestler.points[:OC02_xx]}\n")
		f.write("OC-3-(XX) (0 or 1), #{wrestler.points[:OC03_xx]}\n")
		f.write("OC-4-(XX) (0 or 1), #{wrestler.points[:OC04_xx]}\n")
		f.write("OC-5-(XX) (0 or 1), #{wrestler.points[:OC05_xx]}\n")
		f.write("OC-6-(XX) (0 or 1), #{wrestler.points[:OC06_xx]}\n")
		f.write("OC-7-(XX) (0 or 1), #{wrestler.points[:OC07_xx]}\n")
		f.write("OC-8-(XX) (0 or 1), #{wrestler.points[:OC08_xx]}\n")
		f.write("OC-9-(XX) (0 or 1), #{wrestler.points[:OC09_xx]}\n")
		f.write("OC-10-(XX) (0 or 1), #{wrestler.points[:OC10_xx]}\n")
		f.write("OC-11-(XX) (0 or 1), #{wrestler.points[:OC11_xx]}\n")
		f.write("OC-12-(XX) (0 or 1), #{wrestler.points[:OC12_xx]}\n")
		f.write("OC Ropes Roll Probability (x/3), #{wrestler.points[:OC_Ropes_Roll_Probability]}\n")
		f.write("Ropes (S) Roll Probability (x/36), #{wrestler.points[:Ropes_S_Roll_Probability]}\n")
		f.write("R-2-Points, #{wrestler.points[:RO02_points]}\n")
		f.write("R-3-Points, #{wrestler.points[:RO03_points]}\n")
		f.write("R-4-Points, #{wrestler.points[:RO04_points]}\n")
		f.write("R-5-Points, #{wrestler.points[:RO05_points]}\n")
		f.write("R-6-Points, #{wrestler.points[:RO06_points]}\n")
		f.write("R-7-Points, #{wrestler.points[:RO07_points]}\n")
		f.write("R-8-Points, #{wrestler.points[:RO08_points]}\n")
		f.write("R-9-Points, #{wrestler.points[:RO09_points]}\n")
		f.write("R-10-Points, #{wrestler.points[:RO10_points]}\n")
		f.write("R-11-Points, #{wrestler.points[:RO11_points]}\n")
		f.write("R-12-Points, #{wrestler.points[:RO12_points]}\n")
		f.write("R-2-DQ (0 or 1), #{wrestler.points[:RO02_dq]}\n")
		f.write("R-3-DQ (0 or 1), #{wrestler.points[:RO03_dq]}\n")
		f.write("R-4-DQ (0 or 1), #{wrestler.points[:RO04_dq]}\n")
		f.write("R-5-DQ (0 or 1), #{wrestler.points[:RO05_dq]}\n")
		f.write("R-6-DQ (0 or 1), #{wrestler.points[:RO06_dq]}\n")
		f.write("R-7-DQ (0 or 1), #{wrestler.points[:RO07_dq]}\n")
		f.write("R-8-DQ (0 or 1), #{wrestler.points[:RO08_dq]}\n")
		f.write("R-9-DQ (0 or 1), #{wrestler.points[:RO09_dq]}\n")
		f.write("R-10-DQ (0 or 1), #{wrestler.points[:RO10_dq]}\n")
		f.write("R-11-DQ (0 or 1), #{wrestler.points[:RO11_dq]}\n")
		f.write("R-12-DQ (0 or 1), #{wrestler.points[:RO12_dq]}\n")
		f.write("R-2-P/A (0 or 1), #{wrestler.points[:RO02_pa]}\n")
		f.write("R-3-P/A (0 or 1), #{wrestler.points[:RO03_pa]}\n")
		f.write("R-4-P/A (0 or 1), #{wrestler.points[:RO04_pa]}\n")
		f.write("R-5-P/A (0 or 1), #{wrestler.points[:RO05_pa]}\n")
		f.write("R-6-P/A (0 or 1), #{wrestler.points[:RO06_pa]}\n")
		f.write("R-7-P/A (0 or 1), #{wrestler.points[:RO07_pa]}\n")
		f.write("R-8-P/A (0 or 1), #{wrestler.points[:RO08_pa]}\n")
		f.write("R-9-P/A (0 or 1), #{wrestler.points[:RO09_pa]}\n")
		f.write("R-10-P/A (0 or 1), #{wrestler.points[:RO10_pa]}\n")
		f.write("R-11-P/A (0 or 1), #{wrestler.points[:RO11_pa]}\n")
		f.write("R-12-P/A (0 or 1), #{wrestler.points[:RO12_pa]}\n")
		f.write("R-2-* (0 or 1), #{wrestler.points[:RO02_sub]}\n")
		f.write("R-3-* (0 or 1), #{wrestler.points[:RO03_sub]}\n")
		f.write("R-4-* (0 or 1), #{wrestler.points[:RO04_sub]}\n")
		f.write("R-5-* (0 or 1), #{wrestler.points[:RO05_sub]}\n")
		f.write("R-6-* (0 or 1), #{wrestler.points[:RO06_sub]}\n")
		f.write("R-7-* (0 or 1), #{wrestler.points[:RO07_sub]}\n")
		f.write("R-8-* (0 or 1), #{wrestler.points[:RO08_sub]}\n")
		f.write("R-9-* (0 or 1), #{wrestler.points[:RO09_sub]}\n")
		f.write("R-10-* (0 or 1), #{wrestler.points[:RO10_sub]}\n")
		f.write("R-11-* (0 or 1), #{wrestler.points[:RO11_sub]}\n")
		f.write("R-12-* (0 or 1), #{wrestler.points[:RO12_sub]}\n")
		f.write("R-2-(XX) (0 or 1), #{wrestler.points[:RO02_xx]}\n")
		f.write("R-3-(XX) (0 or 1), #{wrestler.points[:RO03_xx]}\n")
		f.write("R-4-(XX) (0 or 1), #{wrestler.points[:RO04_xx]}\n")
		f.write("R-5-(XX) (0 or 1), #{wrestler.points[:RO05_xx]}\n")
		f.write("R-6-(XX) (0 or 1), #{wrestler.points[:RO06_xx]}\n")
		f.write("R-7-(XX) (0 or 1), #{wrestler.points[:RO07_xx]}\n")
		f.write("R-8-(XX) (0 or 1), #{wrestler.points[:RO08_xx]}\n")
		f.write("R-9-(XX) (0 or 1), #{wrestler.points[:RO09_xx]}\n")
		f.write("R-10-(XX) (0 or 1), #{wrestler.points[:RO10_xx]}\n")
		f.write("R-11-(XX) (0 or 1), #{wrestler.points[:RO11_xx]}\n")
		f.write("R-12-(XX) (0 or 1), #{wrestler.points[:RO12_xx]}\n")
		f.write("PriorityS:, #{wrestler.values[:PriorityS]}\n")
		f.write("PRIORITY-TT, #{wrestler.values[:PriorityT]}\n")
		f.write("SUBMISSION (x/36):, #{wrestler.points[:sub_numerator]}\n")
		f.write("TAG TEAM SAVE (x/36):, #{wrestler.points[:tag_save_numerator]}\n")
	
	end

end