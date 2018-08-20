require 'pdf-reader'


def reader(wrestler)
	reader = PDF::Reader.new(wrestler)

	# Run Program
	reader.pages.each do |page|
	 # puts page.fonts
	  # puts page.raw_content
	  # puts page.class

	  # Capture text in String variable
	  wrestler_text = page.text
	  return wrestler_text
	end
end