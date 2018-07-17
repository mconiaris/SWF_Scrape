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
   # puts wrestler.class
   # puts wrestler
   puts wrestler.lines[0]
   puts wrestler.lines[1]
   puts wrestler.lines[2]
   puts wrestler.lines[3]
   puts wrestler.lines[4]
   puts wrestler.lines[5]
   puts wrestler.lines[6]
   puts wrestler.lines[7]
   puts wrestler.lines[8]
   puts wrestler.lines[9]
   puts wrestler.lines[10]
   puts wrestler.lines[11]
   puts wrestler.lines[12]
   puts wrestler.lines[13]
   puts wrestler.lines[14]
   puts wrestler.lines[15]
   puts wrestler.lines[16]
   puts wrestler.lines[17]
   puts wrestler.lines[18]
   puts wrestler.lines[19]
   puts wrestler.lines[20]
   puts wrestler.lines[21]
   puts wrestler.lines[22]
   puts wrestler.lines[23]
   puts wrestler.lines[24]
   puts wrestler.lines[25]
   puts wrestler.lines[26]
   puts wrestler.lines[27]
   puts wrestler.lines[28]
   puts wrestler.lines[29]
   puts wrestler.lines[30]
   puts wrestler.lines[31]
   puts wrestler.lines[32]
   puts wrestler.lines[33]
   puts wrestler.lines[34]
   puts wrestler.lines[35]
   puts wrestler.lines[36]
   puts wrestler.lines[37]
   puts wrestler.lines[38]
   puts wrestler.lines[39]
   puts wrestler.lines[40]
   puts wrestler.lines[41]
   puts wrestler.lines[42]
   puts wrestler.lines[43]
   puts wrestler.lines[44]
   puts wrestler.lines[45]
   puts wrestler.lines[46]
   puts wrestler.lines[47]
   puts wrestler.lines[48]
   puts wrestler.lines[49]
   puts wrestler.lines[50]
 end

