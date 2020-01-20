class Wrestler

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

		f = File.new('files/output/results.csv', 'a')
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

end