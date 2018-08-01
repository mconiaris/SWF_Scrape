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
					w.strip!
					temp_array = w.split(/(\d+)(\D+)(\d+)(\z)/)
					temp_array.shift
					temp_array.shift
					temp_array[0].strip!
					@oc[2] = temp_array
				else
					w.strip!
			binding.pry
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
 end