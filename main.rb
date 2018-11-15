require 'pdf-reader'
require 'pry'
require_relative 'lib/scraper'
require_relative 'lib/wrestler'

# Create Wrestler object
@wrestler = Wrestler.new

# Scrape PDF
@scrape = Scraper.new("files/Zak Knight.pdf")
card = @scrape.card
@scrape.process_card(card)
binding.pry
# binding.pry
# TODO Add functionality to select files from computer.
