require 'pry'
require_relative 'reader'
require_relative 'wrestler'

wrestler_text = reader("files/Zak Knight.pdf")
#Create Wrestler object
wrestler = Wrestler.new

# puts wrestler_text
wrestler.process_text(wrestler_text)