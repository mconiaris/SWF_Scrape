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
		puts "Card Rating: #{wrestler.statistics[:card_rating]}"
		puts "OC Probability: #{wrestler.statistics[:oc_probability]}"
		puts "Total Points-Per-Round: #{wrestler.statistics[:total_card_points_per_round]}"
		puts "DQ Probability-Per-Round: #{wrestler.statistics[:dq_probability_per_round]}"
		puts "P/A Probability-Per-Round: #{wrestler.statistics[:pa_probability_per_round]}"
		puts "Submission Roll Probability-Per-Round: #{wrestler.statistics[:sub_probability_per_round]}"
		puts "XX Roll Probability-Per-Round: #{wrestler.statistics[:xx_probability_per_round]}"
		puts "Submission Loss Probability: #{wrestler.statistics[:submission_loss_probabilty]}"
		puts "Tag Team Save Probability: #{wrestler.statistics[:tag_team_save_probabilty]}"
		puts "\n"

		f = File.new('files/results.csv', 'a')
		f.write("#{wrestler.values[:name]},#{wrestler.values[:Set]}, #{wrestler.values[:PriorityS]}, #{wrestler.values[:PriorityT]}, #{wrestler.statistics[:tt_probability]}, #{wrestler.statistics[:card_rating]}, #{wrestler.statistics[:oc_probability]}, #{wrestler.statistics[:total_card_points_per_round]}, #{wrestler.statistics[:dq_probability_per_round]}, #{wrestler.statistics[:pa_probability_per_round]}, #{wrestler.statistics[:sub_probability_per_round]}, #{wrestler.statistics[:xx_probability_per_round]}, #{wrestler.statistics[:submission_loss_probabilty]}, #{wrestler.statistics[:tag_team_save_probabilty]}, \n")
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
		f.write("GC-OC Roll (x/36):, #{wrestler.points[:OC]}\n")
		f.write("GC-TT Roll (x/36):, 0\n")
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
		f.write("Specialty Roll Probability in OC (x/36), #{wrestler.points[:Specialty_Roll_Probability_in_OC]}\n")
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
		f.write("OC-2-DQ (0 or 1), 0\n")
		f.write("OC-3-DQ (0 or 1), 0\n")
		f.write("OC-4-DQ (0 or 1), 0\n")
		f.write("OC-5-DQ (0 or 1), 0\n")
		f.write("OC-6-DQ (0 or 1), 0\n")
		f.write("OC-7-DQ (0 or 1), 0\n")
		f.write("OC-8-DQ (0 or 1), 0\n")
		f.write("OC-9-DQ (0 or 1), 0\n")
		f.write("OC-10-DQ (0 or 1), 0\n")
		f.write("OC-11-DQ (0 or 1), 0\n")
		f.write("OC-12-DQ (0 or 1), 0\n")
		f.write("OC-2-P/A (0 or 1), #{wrestler.points[:OC02_pa]}\n")
		f.write("OC-3-P/A (0 or 1), 0\n")
		f.write("OC-4-P/A (0 or 1), 0\n")
		f.write("OC-5-P/A (0 or 1), 0\n")
		f.write("OC-6-P/A (0 or 1), 0\n")
		f.write("OC-7-P/A (0 or 1), 0\n")
		f.write("OC-8-P/A (0 or 1), 0\n")
		f.write("OC-9-P/A (0 or 1), 0\n")
		f.write("OC-10-P/A (0 or 1), 0\n")
		f.write("OC-11-P/A (0 or 1), 0\n")
		f.write("OC-12-P/A (0 or 1), 0\n")
		f.write("OC-2-* (0 or 1), 0\n")
		f.write("OC-3-* (0 or 1), 0\n")
		f.write("OC-4-* (0 or 1), 0\n")
		f.write("OC-5-* (0 or 1), 0\n")
		f.write("OC-6-* (0 or 1), 0\n")
		f.write("OC-7-* (0 or 1), 0\n")
		f.write("OC-8-* (0 or 1), 0\n")
		f.write("OC-9-* (0 or 1), 0\n")
		f.write("OC-10-* (0 or 1), 0\n")
		f.write("OC-11-* (0 or 1), 0\n")
		f.write("OC-12-* (0 or 1), 0\n")
		f.write("OC-2-(XX) (0 or 1), 0\n")
		f.write("OC-3-(XX) (0 or 1), 0\n")
		f.write("OC-4-(XX) (0 or 1), 0\n")
		f.write("OC-5-(XX) (0 or 1), 0\n")
		f.write("OC-6-(XX) (0 or 1), 0\n")
		f.write("OC-7-(XX) (0 or 1), 0\n")
		f.write("OC-8-(XX) (0 or 1), 0\n")
		f.write("OC-9-(XX) (0 or 1), 0\n")
		f.write("OC-10-(XX) (0 or 1), 0\n")
		f.write("OC-11-(XX) (0 or 1), 0\n")
		f.write("OC-12-(XX) (0 or 1), 0\n")
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
		f.write("R-2-DQ (0 or 1), 0\n")
		f.write("R-3-DQ (0 or 1), 0\n")
		f.write("R-4-DQ (0 or 1), 0\n")
		f.write("R-5-DQ (0 or 1), 0\n")
		f.write("R-6-DQ (0 or 1), 0\n")
		f.write("R-7-DQ (0 or 1), 0\n")
		f.write("R-8-DQ (0 or 1), 0\n")
		f.write("R-9-DQ (0 or 1), 0\n")
		f.write("R-10-DQ (0 or 1), 0\n")
		f.write("R-11-DQ (0 or 1), 0\n")
		f.write("R-12-DQ (0 or 1), 0\n")
		f.write("R-2-P/A (0 or 1), 0\n")
		f.write("R-3-P/A (0 or 1), 0\n")
		f.write("R-4-P/A (0 or 1), 0\n")
		f.write("R-5-P/A (0 or 1), 0\n")
		f.write("R-6-P/A (0 or 1), 0\n")
		f.write("R-7-P/A (0 or 1), 0\n")
		f.write("R-8-P/A (0 or 1), 0\n")
		f.write("R-9-P/A (0 or 1), 0\n")
		f.write("R-10-P/A (0 or 1), 0\n")
		f.write("R-11-P/A (0 or 1), 0\n")
		f.write("R-12-P/A (0 or 1), 0\n")
		f.write("R-2-* (0 or 1), 0\n")
		f.write("R-3-* (0 or 1), 0\n")
		f.write("R-4-* (0 or 1), 0\n")
		f.write("R-5-* (0 or 1), 0\n")
		f.write("R-6-* (0 or 1), 0\n")
		f.write("R-7-* (0 or 1), 0\n")
		f.write("R-8-* (0 or 1), 0\n")
		f.write("R-9-* (0 or 1), 0\n")
		f.write("R-10-* (0 or 1),0\n")
		f.write("R-11-* (0 or 1),0\n")
		f.write("R-12-* (0 or 1),0\n")
		f.write("R-2-(XX) (0 or 1), 0\n")
		f.write("R-3-(XX) (0 or 1), 0\n")
		f.write("R-4-(XX) (0 or 1), 0\n")
		f.write("R-5-(XX) (0 or 1), 0\n")
		f.write("R-6-(XX) (0 or 1), 0\n")
		f.write("R-7-(XX) (0 or 1), 0\n")
		f.write("R-8-(XX) (0 or 1), 0\n")
		f.write("R-9-(XX) (0 or 1), 0\n")
		f.write("R-10-(XX) (0 or 1), 0\n")
		f.write("R-11-(XX) (0 or 1), 0\n")
		f.write("R-12-(XX) (0 or 1), 0\n")
		f.write("PriorityS:, #{wrestler.values[:PriorityS]}\n")
		f.write("PRIORITY-TT, #{wrestler.values[:PriorityT]}\n")
		f.write("SUBMISSION (x/36):, 0\n")
		f.write("TAG TEAM SAVE (x/36):, 0\n")
	
	end

end