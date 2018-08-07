require 'pdf-reader'
require 'pry'

reader = PDF::Reader.new("files/Zak Knight.pdf")

class Wrestler

	def initialize
		puts "New Wrestler Created"
		@file_name
		@name
		@gc = Hash.new
		@oc = Hash.new(@oc_moves = Array.new)
		@dc = Hash.new
		@specialty = Hash.new
		@ropes = Array.new
		@sub
		@tag_team
		@singles_priority
		@tag_team_priority
	end

	def get_name
		@name
	end

	def set_name(name)
		@name = name
	end

	def set_file_name(file_name)
		@file_name = file_name
	end

	def process_offense(text)
		# Assign OC Move
		text.strip!
		move = text.split(/(\d+)(\D+)(\d+)(.+|\z)/)
		move.shift
		# Check for errors
		if move[1] != nil
			move[1].strip!
		end
		# Check to see if OFFENSIVE CARD move has a P/A, Sub, etc.
		if move[3] != nil
		 move[3].strip!
		end
		@oc[move[0].to_i] = move
		index = move[0].to_i
		@oc[index].shift
		puts @gc.sort.to_h
		puts @oc.sort.to_h
		puts "\n\n"
	end

	# Fix issue with 3 OC 8 OC?TT to see why it is not loading.
	def process_defense(text)
		puts "processing defense"
		text.strip!
		moves = text.split(/(\d)\s+(A|B|C|REVERSE)\s+(\d+)\s+(A|B|C|REVERSE)\s+(\d+\s+.+)/)
		off = moves[5]
		@dc[moves[1]] = moves[2]
		@dc[moves[3]] = moves[4]
		process_offense(off)
		puts "General Card: " + @gc.sort.to_h.to_s
		puts "Offensive Card: " + @oc.sort.to_h.to_s
		puts "Defensive Card: " + @dc.sort.to_h.to_s
		puts "\n\n"
		binding.pry
	end

	def process_text(wrestler_text)
		# Caputre text lines into an array
  	wrestler_text_array = wrestler_text.lines
  	puts wrestler_text_array

		# Split wrestler_text_array lines by line space
	  wrestler_text_array.each {
	  	|w| wrestler_text_array
	  		puts "Processing Text: " + w
	  		# Create switch statement to determine REGEX
				case w
				when /OFFENSIVE CARD/
					# Define Wrestler Name
					puts "Defining wrestler's name"
					# Remove OFFENSIVE CARD from String text
					w.slice!(/OFFENSIVE CARD/)
					w.strip!
					set_name(w)
					puts "Wrestler's Name: " + @name
				when /\A\n/
					# Skips lines that just contain a newline character
				when /GENERAL CARD/
					w.slice!(/GENERAL CARD/)
					process_offense(w)
				when /(\d)\s+(OC|DC|TT)\s+(\d+).+(OC|DC|TT)(.+)/
					w.strip!

					# Assign GC
					# Look into 10, 11 & 12 GC, which are not working properly.
					temp_array = w.split(/(\d)\s+(OC|DC|TT).+(\d+).+(OC|DC|TT)(.+)/)
					temp_array.shift
					@gc[temp_array[0]] = temp_array[1]
					@gc[temp_array[2]] = temp_array[3]

					# Assign OC Move
					process_offense(temp_array[4])
				when /\s+(OC|DC|TT)\s+(\d+)\s+(.+)/
					process_offense(w)
				when /DEFENSIVE CARD/
					w.slice!(/DEFENSIVE CARD/)
					process_offense(w)
				when /\s?(\d)\s+(A|B|C|REVERSE)\s+(\d+)\s+(A|B|C|REVERSE)\s+(\d+)\s+(.+)/
					process_defense(w)
				else
					puts "This needs to be checked."
			# binding.pry
				end
	  	}

		

		# Split original text into an array
		# temp_string = pdf.split(/(\d+)(\D+)(\d+)/)
	end

end

# Run Program
reader.pages.each do |page|
   # puts page.fonts
   # puts page.raw_content
   # puts page.class

   #Create Wrestler object
   wrestler = Wrestler.new

   # Capture text in String variable
   wrestler_text = page.text
   # puts wrestler_text
   wrestler.process_text(wrestler_text)
   return wrestler
 end

 puts wrestler