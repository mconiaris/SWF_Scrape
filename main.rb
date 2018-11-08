require 'pdf-reader'
require 'pry'
require_relative 'lib/scraper'
require_relative 'wrestler'

# Create Wrestler object
@wrestler = Wrestler.new

#TODO: Moves this to scraper.rb and call it from here.
# Scrape PDF
@scrape = Scraper.new("files/Zak Knight.pdf")
card = @scrape.card
@scrape.process_card(card)
# binding.pry
# TODO Add functionality to select files from computer.
