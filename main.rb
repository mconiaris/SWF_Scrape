require 'pdf-reader'
require 'pry'
require_relative 'lib/analyzer'
require_relative 'lib/scraper'
require_relative 'lib/wrestler'


# TODO: Create unit tests for each method
# TODO: Refactor code to make it clearer. Improve notes.
# TODO: Add funcionality to select files and use the program.
# TODO: Factor out scraping code to DRY

def scraping(file)
	# Scrape PDF
	@scrape = Scraper.new(file)

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

	# binding.pry

	@wrestler.wrestler_output(@wrestler)
	@wrestler.wrestler_values_output(@wrestler)
end


def scraping_converted(file)
	# Scrape PDF
	@scrape = Scraper.new(file)

	# Isolate card moves array
	card = @scrape.card

	# Convert move array into a hash and fix formatting.
	moves = @scrape.process_converted_card(card)

	# Create Wrestler object
	@wrestler = Wrestler.new(moves)
	@analyzer = Analyzer.new
	stats = @analyzer.analyze(@wrestler)

	# Add stats to wrestler instance
	@wrestler.statistics = stats
	@wrestler.wrestler_output(@wrestler)
end


# Cycle through input file for PDF files.
f = File.new('files/results.csv', 'a')
f.write("Name, Set, Singles Priority, Tag Team Priority, TT Probability, Card Rating, OC Probability, Total Card Points Per Round, DQ Probability Per Round, P/A Probability Per Round, Sub Probability Per Round, XX Probability Per Round, Submission Loss Probabilty, Tag Team Save Probabilty, \n")
f.close

puts "Press 1 for an original card or 2 for a scanned special."
x = gets.chomp
if x == '1'
	# For PDFs
	File.open("files/input.txt", "r") do |f|
	  f.each_line do |line|
	    scraping(line.chomp)
	  end  
	  f.close
	end
elsif x == '2'
	# For my Specials
	File.open("files/input_converted.txt", "r") do |f|
	  f.each_line do |line|
	    scraping_converted(line.chomp)
	  end  
	  f.close
	end
else
	puts 'Inccorect option.'
end