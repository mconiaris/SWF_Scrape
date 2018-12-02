require 'pdf-reader'
require 'pry'
require_relative 'lib/analyzer'
require_relative 'lib/scraper'
require_relative 'lib/wrestler'


# Scrape PDF
@scrape = Scraper.new("files/Zak Knight.pdf")

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
puts "#{@wrestler.values[:name]}: #{@wrestler.statistics}"

# TODO: Create unit tests for each method
# TODO: Refactor code to make it clearer. Improve notes.
# TODO: Revise README.md
# TODO: Add funcionality to select files and use the program.

