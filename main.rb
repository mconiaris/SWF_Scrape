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
	wrestler_output(@wrestler)
end


# TODO: Factor out scraping code to DRY
def scraping_converted(file)
	# Scrape PDF
	@scrape = Scraper.new(file)

	# Isolate card moves array
	card = @scrape.card

	# Convert move array into a hash and fix formatting.
	moves = @scrape.process_converted_card(card)

	# Create Wrestler object
	@wrestler = Wrestler.new(moves)
	@analyzer = Analyzer.new
	stats = @analyzer.analyze(@wrestler)

	# TODO: Move this printout to Wrestler Object
	# Add stats to wrestler instance
	@wrestler.statistics = stats
	wrestler_output(@wrestler)
end

def wrestler_output(wrestler)
	puts "Name: #{@wrestler.values[:name]}"
	puts "Set: #{@wrestler.values[:Set]}"
	puts "Singles Priority: #{@wrestler.values[:PriorityS]}"
	puts "Tag Team Priority: #{@wrestler.values[:PriorityT]}"
	puts "TT Probability: #{@wrestler.statistics[:tt_probability]}"
	puts "Card Rating: #{@wrestler.statistics[:card_rating]}"
	puts "OC Probability: #{@wrestler.statistics[:oc_probability]}"
	puts "Total Points-Per-Round: #{@wrestler.statistics[:total_card_points_per_round]}"
	puts "DQ Probability-Per-Round: #{@wrestler.statistics[:dq_probability_per_round]}"
	puts "P/A Probability-Per-Round: #{@wrestler.statistics[:pa_probability_per_round]}"
	puts "Submission Roll Probability-Per-Round: #{@wrestler.statistics[:sub_probability_per_round]}"
	puts "XX Roll Probability-Per-Round: #{@wrestler.statistics[:xx_probability_per_round]}"
	puts "Submission Loss Probability: #{@wrestler.statistics[:submission_loss_probabilty]}"
	puts "Tag Team Save Probability: #{@wrestler.statistics[:tag_team_save_probabilty]}"
	puts "\n"

	f = File.new('files/results.csv', 'a')
	f.write("#{@wrestler.values[:name]}, #{@wrestler.values[:Set]}, #{@wrestler.values[:PriorityS]}, #{@wrestler.values[:PriorityT]}, #{@wrestler.statistics[:tt_probability]}, #{@wrestler.statistics[:card_rating]}, #{@wrestler.statistics[:oc_probability]}, #{@wrestler.statistics[:total_card_points_per_round]}, #{@wrestler.statistics[:dq_probability_per_round]}, #{@wrestler.statistics[:pa_probability_per_round]}, #{@wrestler.statistics[:sub_probability_per_round]}, #{@wrestler.statistics[:xx_probability_per_round]}, #{@wrestler.statistics[:submission_loss_probabilty]}, #{@wrestler.statistics[:tag_team_save_probabilty]}, \n")
	f.close
end


# TODO: Create unit tests for each method
# TODO: Refactor code to make it clearer. Improve notes.
# TODO: Revise README.md
# TODO: Add funcionality to select files and use the program.



# scraping("/Users/mconiaris/Documents/SWF/SWF Original Game Card Sets/83/83_13BillyGraham.pdf")

# Cycle through input file for PDF files.


f = File.new('files/results.csv', 'a')
	f.write("Name, Set, Singles Priority, Tag Team Priority, TT Probability, Card Rating, OC Probability, Total Card Points Per Round, DQ Probability Per Round, P/A Probability Per Round, Sub Probability Per Round, XX Probability Per Round, Submission Loss Probabilty, Tag Team Save Probabilty, \n")
	f.close


# For PDFs
File.open("files/input.txt", "r") do |f|
  f.each_line do |line|
    scraping(line.chomp)
  end  
  f.close
end 

# # For my Specials
# File.open("files/input.txt", "r") do |f|
#   f.each_line do |line|
#     scraping_converted(line.chomp)
#   end  
#   f.close
# end 


