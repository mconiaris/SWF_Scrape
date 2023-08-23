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
	def wrestler_output

		puts "Name: #{self.values[:name]}"
		puts "Set: #{self.values[:set]}"
		puts "Singles Priority: #{self.values[:prioritys]}"
		puts "Tag Team Priority: #{self.values[:priorityt]}"
		puts "TT Probability: #{self.statistics[:tt_probability]}"
		puts "Card Rating: #{self.statistics[:total_card_rating]}"
		puts "OC Probability: #{self.statistics[:oc_probability]}"
		puts "Total Points-Per-Round: #{self.statistics[:total_card_points_per_round]}"
		puts "DQ Probability-Per-Round: #{self.statistics[:dq_probability_per_round]}"
		puts "P/A Probability-Per-Round: #{self.statistics[:pa_probability_per_round]}"
		puts "Submission Roll Probability-Per-Round: #{self.statistics[:sub_probability_per_round]}"
		puts "XX Roll Probability-Per-Round: #{self.statistics[:xx_probability_per_round]}"
		puts "Submission Loss Probability: #{self.points[:sub_prob]}"
		puts "Tag Team Save Probability: #{self.points[:tag_prob]}"
		puts "\n"

		tt_probability = "%.1f" % (self.statistics[:tt_probability] * 100) + "%"
		card_rating = "%.1f" % self.statistics[:total_card_rating]
		oc_probability = "%.1f" % (self.statistics[:oc_probability] * 100) + "%"
		total_card_points_per_round = "%.3f" % self.statistics[:total_card_points_per_round]
		dq_probability_per_round = "%.1f" % (self.statistics[:dq_probability_per_round] * 100) + "%"
		pa_probability_per_round = "%.1f" % (self.statistics[:pa_probability_per_round] * 100) + "%"
		sub_probability_per_round = "%.1f" % (self.statistics[:sub_probability_per_round] * 100) + "%"
		xx_probability_per_round = "%.1f" % (self.statistics[:xx_probability_per_round] * 100) + "%"
		
		sub_prob = "%.1f" % (self.points[:sub_prob] * 100) + "%"
		tag_prob = "%.1f" % (self.points[:tag_prob] * 100) + "%"

		f = File.new('files/results.csv', 'a')
		f.write("#{self.values[:name]},#{self.values[:set]}, #{self.values[:prioritys]}, #{self.values[:priorityt]}, #{tt_probability}, #{card_rating}, #{oc_probability}, #{total_card_points_per_round}, #{dq_probability_per_round}, #{pa_probability_per_round}, #{sub_probability_per_round}, #{xx_probability_per_round}, #{sub_prob}, #{tag_prob}, \n")
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
		sub_prob = "%.1f" % (self.points[:sub_prob] * 100) + "%"
		tag_prob = "%.1f" % (self.points[:tag_prob] * 100) + "%"

		f = File.new('files/raw_results.csv', 'a')
		f.write("#{self.values[:set]},")
		self.values.each { |k, v|
			f.write(v, ",") 
		}
		f.write("#{tt_probability}, #{card_rating}, #{oc_probability}, #{total_card_points_per_round}, #{dq_probability_per_round}, #{pa_probability_per_round}, #{sub_probability_per_round}, #{xx_probability_per_round}, #{sub_prob}, #{tag_prob}, #{self.values[:sub][0]}, #{self.values[:sub][1]}, #{self.values[:tag][0]}, #{self.values[:tag][1]}\n")
		f.close
	end

	def wrestler_values_output
		f = File.new("files/output/#{self.values[:name]}_#{self.values[:set]}_values.csv", 'a')
		self.values.each { |k, v|
			f.write(k, ",", v, "\n")
		}
		f.write("Sub:, #{self.values[:sub][0]}-#{self.values[:sub][1]}\n")
		f.write("Tag:, #{self.values[:tag][0]}-#{self.values[:tag][1]}\n")
		f.write("Priority:, #{self.values[:prioritys]}/#{self.values[:priorityt]}\n")
	end

	def wrestler_points_output
		f = File.new("files/output/#{self.values[:name]}_#{self.values[:set]}_points.csv", 'a')
		f.write("\nName:, #{self.values[:name]}\n")
		f.write("GC-OC Roll (x/36):, #{self.points[:oc_enumerator]}\n")
		f.write("GC-TT Roll (x/36):, #{self.points[:gc_tt_enumerator]}\n")
		f.write("DC02_points:, #{self.points[:dc02_points]}\n")
 		f.write("DC03_points:, #{self.points[:dc03_points]}\n")
 		f.write("DC04_points:, #{self.points[:dc04_points]}\n")
 		f.write("DC05_points:, #{self.points[:dc05_points]}\n")
 		f.write("DC06_points:, #{self.points[:dc06_points]}\n")
 		f.write("DC07_points:, #{self.points[:dc07_points]}\n")
 		f.write("DC08_points:, #{self.points[:dc08_points]}\n")
 		f.write("DC09_points:, #{self.points[:dc09_points]}\n")
 		f.write("DC10_points:, #{self.points[:dc10_points]}\n")
 		f.write("DC11_points:, #{self.points[:dc11_points]}\n")
 		f.write("DC12_points:, #{self.points[:dc12_points]}\n")
 		f.write("Reverse (x/36), #{self.points[:Reverse]}\n")
		f.write("Specialty Roll Probability in OC (x/36), #{self.points[:Specialty_Roll_Enumerator_in_OC]}\n")
		f.write("Specialty-1-Points, #{self.points[:s1_points]}\n")
		f.write("Specialty-2-Points, #{self.points[:s2_points]}\n")
		f.write("Specialty-3-Points, #{self.points[:s3_points]}\n")
		f.write("Specialty-4-Points, #{self.points[:s4_points]}\n")
		f.write("Specialty-5-Points, #{self.points[:s5_points]}\n")
		f.write("Specialty-6-Points, #{self.points[:s6_points]}\n")
		f.write("Specialty Roll Probability-DQ (x/6), #{self.points[:s_roll_prob_dq]}\n")
		f.write("Specialty Roll Probability-P/A (x/6), #{self.points[:s_roll_prob_pa]}\n")
		f.write("Specialty Roll Probability-* (x/6), #{self.points[:s_roll_prob_sub]}\n")
		f.write("Specialty Roll Probability-XX (x/6), #{self.points[:s_roll_prob_xx]}\n")
		f.write("OC-2-Points, #{self.points[:oc02_points]}\n")
		f.write("OC-3-Points, #{self.points[:oc03_points]}\n")
		f.write("OC-4-Points, #{self.points[:oc04_points]}\n")
		f.write("OC-5-Points, #{self.points[:oc05_points]}\n")
		f.write("OC-6-Points, #{self.points[:oc06_points]}\n")
		f.write("OC-7-Points, #{self.points[:oc07_points]}\n")
		f.write("OC-8-Points, #{self.points[:oc08_points]}\n")
		f.write("OC-9-Points, #{self.points[:oc09_points]}\n")
		f.write("OC-10-Points, #{self.points[:oc10_points]}\n")
		f.write("OC-11-Points, #{self.points[:oc11_points]}\n")
		f.write("OC-12-Points, #{self.points[:oc12_points]}\n")
		f.write("OC-2-DQ (0 or 1), #{self.points[:oc02_dq]}\n")
		f.write("OC-3-DQ (0 or 1), #{self.points[:oc03_dq]}\n")
		f.write("OC-4-DQ (0 or 1), #{self.points[:oc04_dq]}\n")
		f.write("OC-5-DQ (0 or 1), #{self.points[:oc05_dq]}\n")
		f.write("OC-6-DQ (0 or 1), #{self.points[:oc06_dq]}\n")
		f.write("OC-7-DQ (0 or 1), #{self.points[:oc07_dq]}\n")
		f.write("OC-8-DQ (0 or 1), #{self.points[:oc08_dq]}\n")
		f.write("OC-9-DQ (0 or 1), #{self.points[:oc09_dq]}\n")
		f.write("OC-10-DQ (0 or 1), #{self.points[:oc10_dq]}\n")
		f.write("OC-11-DQ (0 or 1), #{self.points[:oc11_dq]}\n")
		f.write("OC-12-DQ (0 or 1), #{self.points[:oc12_dq]}\n")
		f.write("OC-2-P/A (0 or 1), #{self.points[:oc02_pa]}\n")
		f.write("OC-3-P/A (0 or 1), #{self.points[:oc03_pa]}\n")
		f.write("OC-4-P/A (0 or 1), #{self.points[:oc04_pa]}\n")
		f.write("OC-5-P/A (0 or 1), #{self.points[:oc05_pa]}\n")
		f.write("OC-6-P/A (0 or 1), #{self.points[:oc06_pa]}\n")
		f.write("OC-7-P/A (0 or 1), #{self.points[:oc07_pa]}\n")
		f.write("OC-8-P/A (0 or 1), #{self.points[:oc08_pa]}\n")
		f.write("OC-9-P/A (0 or 1), #{self.points[:oc09_pa]}\n")
		f.write("OC-10-P/A (0 or 1), #{self.points[:oc10_pa]}\n")
		f.write("OC-11-P/A (0 or 1), #{self.points[:oc11_pa]}\n")
		f.write("OC-12-P/A (0 or 1), #{self.points[:oc12_pa]}\n")
		f.write("OC-2-* (0 or 1), #{self.points[:oc02_sub]}\n")
		f.write("OC-3-* (0 or 1), #{self.points[:oc03_sub]}\n")
		f.write("OC-4-* (0 or 1), #{self.points[:oc04_sub]}\n")
		f.write("OC-5-* (0 or 1), #{self.points[:oc05_sub]}\n")
		f.write("OC-6-* (0 or 1), #{self.points[:oc06_sub]}\n")
		f.write("OC-7-* (0 or 1), #{self.points[:oc07_sub]}\n")
		f.write("OC-8-* (0 or 1), #{self.points[:oc08_sub]}\n")
		f.write("OC-9-* (0 or 1), #{self.points[:oc09_sub]}\n")
		f.write("OC-10-* (0 or 1), #{self.points[:oc10_sub]}\n")
		f.write("OC-11-* (0 or 1), #{self.points[:oc11_sub]}\n")
		f.write("OC-12-* (0 or 1), #{self.points[:oc12_sub]}\n")
		f.write("OC-2-(XX) (0 or 1), #{self.points[:oc02_xx]}\n")
		f.write("OC-3-(XX) (0 or 1), #{self.points[:oc03_xx]}\n")
		f.write("OC-4-(XX) (0 or 1), #{self.points[:oc04_xx]}\n")
		f.write("OC-5-(XX) (0 or 1), #{self.points[:oc05_xx]}\n")
		f.write("OC-6-(XX) (0 or 1), #{self.points[:oc06_xx]}\n")
		f.write("OC-7-(XX) (0 or 1), #{self.points[:oc07_xx]}\n")
		f.write("OC-8-(XX) (0 or 1), #{self.points[:oc08_xx]}\n")
		f.write("OC-9-(XX) (0 or 1), #{self.points[:oc09_xx]}\n")
		f.write("OC-10-(XX) (0 or 1), #{self.points[:oc10_xx]}\n")
		f.write("OC-11-(XX) (0 or 1), #{self.points[:oc11_xx]}\n")
		f.write("OC-12-(XX) (0 or 1), #{self.points[:oc12_xx]}\n")
		f.write("OC Ropes Roll Probability (x/3), #{self.points[:oc_ropes_roll_probability]}\n")
		f.write("Ropes (S) Roll Probability (x/36), #{self.points[:ropes_s_roll_probability]}\n")
		f.write("R-2-Points, #{self.points[:ro02_points]}\n")
		f.write("R-3-Points, #{self.points[:ro03_points]}\n")
		f.write("R-4-Points, #{self.points[:ro04_points]}\n")
		f.write("R-5-Points, #{self.points[:ro05_points]}\n")
		f.write("R-6-Points, #{self.points[:ro06_points]}\n")
		f.write("R-7-Points, #{self.points[:ro07_points]}\n")
		f.write("R-8-Points, #{self.points[:ro08_points]}\n")
		f.write("R-9-Points, #{self.points[:ro09_points]}\n")
		f.write("R-10-Points, #{self.points[:ro10_points]}\n")
		f.write("R-11-Points, #{self.points[:ro11_points]}\n")
		f.write("R-12-Points, #{self.points[:ro12_points]}\n")
		f.write("R-2-DQ (0 or 1), #{self.points[:ro02_dq]}\n")
		f.write("R-3-DQ (0 or 1), #{self.points[:ro03_dq]}\n")
		f.write("R-4-DQ (0 or 1), #{self.points[:ro04_dq]}\n")
		f.write("R-5-DQ (0 or 1), #{self.points[:ro05_dq]}\n")
		f.write("R-6-DQ (0 or 1), #{self.points[:ro06_dq]}\n")
		f.write("R-7-DQ (0 or 1), #{self.points[:ro07_dq]}\n")
		f.write("R-8-DQ (0 or 1), #{self.points[:ro08_dq]}\n")
		f.write("R-9-DQ (0 or 1), #{self.points[:ro09_dq]}\n")
		f.write("R-10-DQ (0 or 1), #{self.points[:ro10_dq]}\n")
		f.write("R-11-DQ (0 or 1), #{self.points[:ro11_dq]}\n")
		f.write("R-12-DQ (0 or 1), #{self.points[:ro12_dq]}\n")
		f.write("R-2-P/A (0 or 1), #{self.points[:ro02_pa]}\n")
		f.write("R-3-P/A (0 or 1), #{self.points[:ro03_pa]}\n")
		f.write("R-4-P/A (0 or 1), #{self.points[:ro04_pa]}\n")
		f.write("R-5-P/A (0 or 1), #{self.points[:ro05_pa]}\n")
		f.write("R-6-P/A (0 or 1), #{self.points[:ro06_pa]}\n")
		f.write("R-7-P/A (0 or 1), #{self.points[:ro07_pa]}\n")
		f.write("R-8-P/A (0 or 1), #{self.points[:ro08_pa]}\n")
		f.write("R-9-P/A (0 or 1), #{self.points[:ro09_pa]}\n")
		f.write("R-10-P/A (0 or 1), #{self.points[:ro10_pa]}\n")
		f.write("R-11-P/A (0 or 1), #{self.points[:ro11_pa]}\n")
		f.write("R-12-P/A (0 or 1), #{self.points[:ro12_pa]}\n")
		f.write("R-2-* (0 or 1), #{self.points[:ro02_sub]}\n")
		f.write("R-3-* (0 or 1), #{self.points[:ro03_sub]}\n")
		f.write("R-4-* (0 or 1), #{self.points[:ro04_sub]}\n")
		f.write("R-5-* (0 or 1), #{self.points[:ro05_sub]}\n")
		f.write("R-6-* (0 or 1), #{self.points[:ro06_sub]}\n")
		f.write("R-7-* (0 or 1), #{self.points[:ro07_sub]}\n")
		f.write("R-8-* (0 or 1), #{self.points[:ro08_sub]}\n")
		f.write("R-9-* (0 or 1), #{self.points[:ro09_sub]}\n")
		f.write("R-10-* (0 or 1), #{self.points[:ro10_sub]}\n")
		f.write("R-11-* (0 or 1), #{self.points[:ro11_sub]}\n")
		f.write("R-12-* (0 or 1), #{self.points[:ro12_sub]}\n")
		f.write("R-2-(XX) (0 or 1), #{self.points[:ro02_xx]}\n")
		f.write("R-3-(XX) (0 or 1), #{self.points[:ro03_xx]}\n")
		f.write("R-4-(XX) (0 or 1), #{self.points[:ro04_xx]}\n")
		f.write("R-5-(XX) (0 or 1), #{self.points[:ro05_xx]}\n")
		f.write("R-6-(XX) (0 or 1), #{self.points[:ro06_xx]}\n")
		f.write("R-7-(XX) (0 or 1), #{self.points[:ro07_xx]}\n")
		f.write("R-8-(XX) (0 or 1), #{self.points[:ro08_xx]}\n")
		f.write("R-9-(XX) (0 or 1), #{self.points[:ro09_xx]}\n")
		f.write("R-10-(XX) (0 or 1), #{self.points[:ro10_xx]}\n")
		f.write("R-11-(XX) (0 or 1), #{self.points[:ro11_xx]}\n")
		f.write("R-12-(XX) (0 or 1), #{self.points[:ro12_xx]}\n")
		f.write("PriorityS:, #{self.values[:prioritys]}\n")
		f.write("PRIORITY-TT, #{self.values[:priorityt]}\n")
		f.write("SUBMISSION (x/36):, #{self.points[:sub_numerator]}\n")
		f.write("TAG TEAM SAVE (x/36):, #{self.points[:tag_save_numerator]}\n")
	
	end

	# TODO: Change hash values to that converting them is not needed.
	def wrestler_hash_output
		wrestler_hash_output = self.values

		wrestler_hash_output["name"] = wrestler_hash_output.delete :name
		wrestler_hash_output["set"] = wrestler_hash_output.delete :set

		wrestler_hash_output["gc02"] = wrestler_hash_output.delete :gc02
		wrestler_hash_output["gc03"] = wrestler_hash_output.delete :gc03
		wrestler_hash_output["gc04"] = wrestler_hash_output.delete :gc04
		wrestler_hash_output["gc05"] = wrestler_hash_output.delete :gc05
		wrestler_hash_output["gc06"] = wrestler_hash_output.delete :gc06
		wrestler_hash_output["gc07"] = wrestler_hash_output.delete :gc07
		wrestler_hash_output["gc08"] = wrestler_hash_output.delete :gc08
		wrestler_hash_output["gc09"] = wrestler_hash_output.delete :gc09
		wrestler_hash_output["gc10"] = wrestler_hash_output.delete :gc10
		wrestler_hash_output["gc11"] = wrestler_hash_output.delete :gc11
		wrestler_hash_output["gc12"] = wrestler_hash_output.delete :gc12

		wrestler_hash_output["dc02"] = wrestler_hash_output.delete :dc02
		wrestler_hash_output["dc03"] = wrestler_hash_output.delete :dc03
		wrestler_hash_output["dc04"] = wrestler_hash_output.delete :dc04
		wrestler_hash_output["dc05"] = wrestler_hash_output.delete :dc05
		wrestler_hash_output["dc06"] = wrestler_hash_output.delete :dc06
		wrestler_hash_output["dc07"] = wrestler_hash_output.delete :dc07
		wrestler_hash_output["dc08"] = wrestler_hash_output.delete :dc08
		wrestler_hash_output["dc09"] = wrestler_hash_output.delete :dc09
		wrestler_hash_output["dc10"] = wrestler_hash_output.delete :dc10
		wrestler_hash_output["dc11"] = wrestler_hash_output.delete :dc11
		wrestler_hash_output["dc12"] = wrestler_hash_output.delete :dc12

		wrestler_hash_output["specialty"] = wrestler_hash_output.delete :specialty

		wrestler_hash_output["s1"] = wrestler_hash_output.delete :s1
		wrestler_hash_output["s2"] = wrestler_hash_output.delete :s2
		wrestler_hash_output["s3"] = wrestler_hash_output.delete :s3
		wrestler_hash_output["s4"] = wrestler_hash_output.delete :s4
		wrestler_hash_output["s5"] = wrestler_hash_output.delete :s5
		wrestler_hash_output["s6"] = wrestler_hash_output.delete :s6

		wrestler_hash_output["subx"] = wrestler_hash_output[:sub][0]
		wrestler_hash_output["suby"] = wrestler_hash_output[:sub][1]
		wrestler_hash_output["tagx"] = wrestler_hash_output[:sub][0]
		wrestler_hash_output["tagy"] = wrestler_hash_output[:sub][1]

		wrestler_hash_output.delete :sub
		wrestler_hash_output.delete :tag

		wrestler_hash_output["prioritys"] = wrestler_hash_output.delete :prioritys
		wrestler_hash_output["priorityt"] = wrestler_hash_output.delete :priorityt

		wrestler_hash_output["oc02"] = wrestler_hash_output.delete :oc02
		wrestler_hash_output["oc03"] = wrestler_hash_output.delete :oc03
		wrestler_hash_output["oc04"] = wrestler_hash_output.delete :oc04
		wrestler_hash_output["oc05"] = wrestler_hash_output.delete :oc05
		wrestler_hash_output["oc06"] = wrestler_hash_output.delete :oc06
		wrestler_hash_output["oc07"] = wrestler_hash_output.delete :oc07
		wrestler_hash_output["oc08"] = wrestler_hash_output.delete :oc08
		wrestler_hash_output["oc09"] = wrestler_hash_output.delete :oc09
		wrestler_hash_output["oc10"] = wrestler_hash_output.delete :oc10
		wrestler_hash_output["oc11"] = wrestler_hash_output.delete :oc11
		wrestler_hash_output["oc12"] = wrestler_hash_output.delete :oc12

		wrestler_hash_output["ro02"] = wrestler_hash_output.delete :ro02
		wrestler_hash_output["ro03"] = wrestler_hash_output.delete :ro03
		wrestler_hash_output["ro04"] = wrestler_hash_output.delete :ro04
		wrestler_hash_output["ro05"] = wrestler_hash_output.delete :ro05
		wrestler_hash_output["ro06"] = wrestler_hash_output.delete :ro06
		wrestler_hash_output["ro07"] = wrestler_hash_output.delete :ro07
		wrestler_hash_output["ro08"] = wrestler_hash_output.delete :ro08
		wrestler_hash_output["ro09"] = wrestler_hash_output.delete :ro09
		wrestler_hash_output["ro10"] = wrestler_hash_output.delete :ro10
		wrestler_hash_output["ro11"] = wrestler_hash_output.delete :ro11
		wrestler_hash_output["ro12"] = wrestler_hash_output.delete :ro12

		f = File.new("files/output/#{wrestler_hash_output["name"]}_#{wrestler_hash_output["set"]}_hash.txt", 'a')

		f.write("{")
		wrestler_hash_output.each { |k,v|
			f.write("\"#{k}\"=>\"#{v}\", ")
		}
		f.write("template: nil}")

		f.write("\n\n")
	end

end