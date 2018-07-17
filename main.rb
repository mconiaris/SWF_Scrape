require 'pdf-reader'

reader = PDF::Reader.new("files/Zak Knight.pdf")

# puts reader.pdf_version
# puts reader.info
# puts reader.metadata
# puts reader.page_count


reader.pages.each do |page|
   # puts page.fonts
   wrestler = page.text
   puts wrestler
   # puts page.raw_content
 end

