require 'pdf-reader'
require 'pry'
require_relative 'lib/analyzer'
require_relative 'lib/scraper'
require_relative 'lib/wrestler'

# puts "Enter in a card location: "
# pwg_card = STDIN.gets.chomp
# puts "Looking for #{pwg_card}." 
# binding.pry

pwg_card = "files/Zak Knight.pdf"
# Scrape PDF
# @scrape = Scraper.new("files/Zak Knight.pdf")
@scrape = Scraper.new(pwg_card)

# Isolate card moves array
card = @scrape.card

# Convert move array into a hash and fix formatting.
moves = @scrape.process_card(card)

# Create Wrestler object
@wrestler = Wrestler.new(moves)
@analyzer = Analyzer.new
stats = @analyzer.analyze(@wrestler)

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

# TODO: Create unit tests for each method
# TODO: Refactor code to make it clearer. Improve notes.
# TODO: Revise README.md
# TODO: Add funcionality to select files and use the program.

