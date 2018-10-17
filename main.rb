require 'pdf-reader'
require 'pry'
require 'scraper'
require_relative 'wrestler'

# Create Wrestler object
@wrestler = Wrestler.new

#TODO: Moves this to scraper.rb and call it from here.
# Scrape PDF
reader = PDF::Reader.new("files/Zak Knight.pdf")
binding.pry