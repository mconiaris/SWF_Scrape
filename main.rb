require 'pdf-reader'

reader = PDF::Reader.new("files/Zak Knight.pdf")

# puts reader.pdf_version
# puts reader.info
# puts reader.metadata
# puts reader.page_count


reader.pages.each do |page|
   # puts page.fonts
   # puts page.raw_content

   wrestler = page.text
   puts wrestler.class
   puts wrestler
   wrestler_name = wrestler.lines.first
   puts wrestler_name
 end

