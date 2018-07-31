require 'pdf-reader'
require 'pry'

reader = PDF::Reader.new("files/Zak Knight.pdf")

# puts reader.pdf_version
# puts reader.info
# puts reader.metadata
# puts reader.page_count

class Wrestler

	def initialize(name)
		puts "New Wrestler Created"
		@name = name
		@gc = Hash.new
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

end


def process_text(pdf)
	# Split original text into an array
	temp_string = pdf.split(/(\d+)(\D+)(\d+)/)
end

reader.pages.each do |page|
   # puts page.fonts
   # puts page.raw_content
   # puts page.class

   
   # Capture text in String variable
   wrestler_text = page.text
   # puts wrestler_text

   # Caputre text lines into an array
   wrestler_text_array = wrestler_text.lines

   # Split wrestler_text_array lines by line space
   wrestler_lines_array = Array.new
   wrestler_text_array.each {
   	|w| wrestler_lines_array.push(w.split(' '))
   	puts w
   }
   puts "Wrestler lines array:"
   puts wrestler_lines_array

   # Define Wrestler Name
   puts "wrestler_lines_array[0]" + wrestler_lines_array[0].to_s
   wrestler_name = wrestler_lines_array[0].join(' ')
   puts wrestler_name
   wrestler_name.slice!(/OFFENSIVE CARD/)
   wrestler_name.strip!

   # Create blank wrestler
   wrestler = Wrestler.new(wrestler_name)
   puts "Wrestler Name: " + wrestler.get_name

   # Create OC Hash
   oc = Hash.new
   
   # Process line 2 into Wrestler objects
   puts "wrestler_lines_array[2]: " + wrestler_lines_array[2].to_s
   puts "wrestler_lines_array[2][2]: " + wrestler_lines_array[2][2].to_s

   #
   
   # puts wrestler.lines[3]
   # puts wrestler.lines[4]
   # puts wrestler.lines[5]
   # puts wrestler.lines[6]
   # puts wrestler.lines[7]
   # puts wrestler.lines[8]
   # puts wrestler.lines[9]
   # puts wrestler.lines[10]
   # puts wrestler.lines[11]
   # puts wrestler.lines[12]
   # puts wrestler.lines[13]
   # puts wrestler.lines[14]
   # puts wrestler.lines[15]
   # puts wrestler.lines[16]
   # puts wrestler.lines[17]
   # puts wrestler.lines[18]
   # puts wrestler.lines[19]
   # puts wrestler.lines[20]
   # puts wrestler.lines[21]
   # puts wrestler.lines[22]
   # puts wrestler.lines[23]
   # puts wrestler.lines[24]
   # puts wrestler.lines[25]
   # puts wrestler.lines[26]
   # puts wrestler.lines[27]
   # puts wrestler.lines[28]
   # puts wrestler.lines[29]
   # puts wrestler.lines[30]
   # puts wrestler.lines[31]
   # puts wrestler.lines[32]
   # puts wrestler.lines[33]
   # puts wrestler.lines[34]
   # puts wrestler.lines[35]
   # puts wrestler.lines[36]
   # puts wrestler.lines[37]
   # puts wrestler.lines[38]
   # puts wrestler.lines[39]
   # puts wrestler.lines[40]
   # puts wrestler.lines[41]
   # puts wrestler.lines[42]
   # puts wrestler.lines[43]
   # puts wrestler.lines[44]
   # puts wrestler.lines[45]
   # puts wrestler.lines[46]
   # puts wrestler.lines[47]
   # puts wrestler.lines[48]
   # puts wrestler.lines[49]
   # puts wrestler.lines[50]
 end

