require 'pdf-reader'
require 'pry'
require_relative 'wrestler'

# Create Wrestler object
@wrestler = Wrestler.new

# Scrape PDF
reader = PDF::Reader.new("files/Zak Knight.pdf")
binding.pry