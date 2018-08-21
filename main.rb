require 'pry'
require_relative 'wrestler'

#Create Wrestler object
wrestler = Wrestler.new
# binding.pry
wrestler_text = wrestler.pdf_to_text("files/Zak Knight.pdf")

# puts wrestler_text
wrestler.process_text(wrestler_text)