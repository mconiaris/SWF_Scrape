require 'pdf-reader'
require 'pry'
require_relative 'lib/analyzer'
require_relative 'lib/scraper'
require_relative 'lib/wrestler'



def scraping(file)
	# Scrape PDF
	@scrape = Scraper.new(file)

	# Isolate card moves array
	card = @scrape.card

	# Convert move array into a hash and fix formatting.
	moves = @scrape.process_card(card)

	# Create Wrestler object
	@wrestler = Wrestler.new(moves)
	@analyzer = Analyzer.new
	stats = @analyzer.analyze(@wrestler)

	# TODO: Move this printout to Wrestler Object
	# Add stats to wrestler instance
	@wrestler.statistics = stats
	puts "Name: #{@wrestler.values[:name]}"
	puts "Card Rating: #{@wrestler.statistics[:card_rating]}"
	puts "OC Probability: #{@wrestler.statistics[:oc_probability]}"
	puts "TT Probability: #{@wrestler.statistics[:tt_probability]}"
	puts "Points-Per-Round: #{@wrestler.statistics[:total_card_points_per_round]}"
	puts "DQ Probability-Per-Round: #{@wrestler.statistics[:dq_probability_per_round]}"
	puts "P/A Probability-Per-Round: #{@wrestler.statistics[:pa_probability_per_round]}"
	puts "Submission Roll Probability-Per-Round: #{@wrestler.statistics[:sub_probability_per_round]}"
	puts "XX Roll Probability-Per-Round: #{@wrestler.statistics[:xx_probability_per_round]}"
	puts "DQ Probability-Per-Round: #{@wrestler.statistics[:dq_probability_per_round]}"
	puts "Submission Loss Probability: #{@wrestler.statistics[:submission_loss_probabilty]}"
	puts "Tag Team Save Probability: #{@wrestler.statistics[:tag_team_save_probabilty]}"
	puts "Singles Priority: #{@wrestler.values[:PriorityS]}"
	puts "Tag Team Priority: #{@wrestler.values[:PriorityT]}"
	puts "Set: #{@wrestler.values[:Set]}"
	puts "\n"

	f = File.new('files/results.csv', 'a')
	f.write("#{@wrestler.values[:name]}, #{@wrestler.statistics[:card_rating]}, #{@wrestler.statistics[:oc_probability]}, #{@wrestler.statistics[:tt_probability]}, #{@wrestler.statistics[:total_card_points_per_round]}, #{@wrestler.statistics[:dq_probability_per_round]}, #{@wrestler.statistics[:pa_probability_per_round]}, #{@wrestler.statistics[:sub_probability_per_round]}, #{@wrestler.statistics[:xx_probability_per_round]}, #{@wrestler.statistics[:dq_probability_per_round]}, #{@wrestler.statistics[:submission_loss_probabilty]}#{@wrestler.statistics[:tag_team_save_probabilty]}#{@wrestler.values[:PriorityS]}#{@wrestler.values[:PriorityT]}#{@wrestler.values[:Set]}, \n")
	f.close
end


# TODO: Create unit tests for each method
# TODO: Refactor code to make it clearer. Improve notes.
# TODO: Revise README.md
# TODO: Add funcionality to select files and use the program.

# pwg_card = "files/Zak Knight.pdf"
# scraping(pwg_card)


# scraping("/Users/mconiaris/Documents/SWF/SWF Original Game Card Sets/83/83_13BillyGraham.pdf")

# Cycle through input file for PDF files.
File.open("files/input.txt", "r") do |f|
  f.each_line do |line|
    scraping(line.chomp)
  end  
end 


