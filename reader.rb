require 'pdf-reader'

def reader(wrestler)
	reader = PDF::Reader.new(wrestler)

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
end