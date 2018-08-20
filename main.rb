require 'pry'
require_relative 'reader'
require_relative 'wrestler'

#Create Wrestler object
wrestler = Wrestler.new
wrestler_text = wrestler.reader("files/Zak Knight.pdf")

# puts wrestler_text
wrestler.process_text(wrestler_text)