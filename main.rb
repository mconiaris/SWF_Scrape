require 'pry'
require_relative 'wrestler'

#Create Wrestler object
@wrestler = Wrestler.new
@wrestler_text = @wrestler.pdf_to_text("files/Zak Knight.pdf")
# binding.pry

# puts wrestler_text
@wrestler.process_text(wrestler_text)