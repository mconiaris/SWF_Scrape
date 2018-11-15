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
binding.pry

# TODO Add functionality to select files from computer.
