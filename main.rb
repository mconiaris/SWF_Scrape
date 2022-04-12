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

	# Isolate Moves Points Totals

	@analyzer = Analyzer.new
	points = @analyzer.move_points(moves)

	@wrestler.points = points
	stats = @analyzer.analyze(@wrestler)

	# Add stats to wrestler instance
	@wrestler.statistics = stats

	@wrestler.wrestler_output(@wrestler)
	@wrestler.wrestler_values_output(@wrestler)
	@wrestler.wrestler_points_output(@wrestler)
	@wrestler.wrestler_raw_values_output(@wrestler)

	@wrestler.wrestler_hash_output
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
	points = @analyzer.move_points(moves)

	@wrestler.points = points
	stats = @analyzer.analyze(@wrestler)

	# Add stats to wrestler instance
	@wrestler.statistics = stats

	@wrestler.wrestler_output(@wrestler)
	@wrestler.wrestler_values_output(@wrestler)
	@wrestler.wrestler_points_output(@wrestler)

end

# Cycle through input file for PDF files.
f = File.new('files/results.csv', 'a')
f.write("Name, Set, Singles Priority, Tag Team Priority, TT Probability, Card Rating, OC Probability, Total Card Points Per Round, DQ Probability Per Round, P/A Probability Per Round, Sub Probability Per Round, XX Probability Per Round, Submission Loss Probabilty, Tag Team Save Probabilty, \n")
f.close

f = File.new('files/raw_results.csv', 'a')
f.write("Set, name,	GC02,	GC03,	GC04,	GC05,	GC06,	GC07,	GC08,	GC09,	GC10,	GC11,	GC12,	DC02,	DC03,	DC04,	DC05,	DC06,	DC07,	DC08,	DC09,	DC10,	DC11,	DC12,	Specialty,	S1,	S2,	S3,	S4,	S5,	S6,	Sub, Sub, Tag,	Tag,	PriorityS,	PriorityT,	OC02,	OC03,	OC04,	OC05,	OC06,	OC07,	OC08,	OC09,	OC10,	OC11,	OC12,	RO02,	RO03,	RO04,	RO05,	RO06,	RO07,	RO08,	RO09,	RO10,	RO11,	RO12,	Set, TT Probability, Card Rating, OC Probability, Total Card Points Per Round, DQ Probability Per Round, P/A Probability Per Round, Sub Probability Per Round, XX Probability Per Round, Submission Loss Probabilty, Tag Team Save Probabilty, Sub(1), Sub(2), Tag(1), Tag(2)\n")
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
elsif x == '3'
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