RSpec.describe Scraper do
	before(:contaxt) do
		@reader = PDF::Reader.new("files/Zak Knight.pdf")
	end
	
	describe "Zak Knight PDF" do
		it "should have one page" do
			exect (@reader.page_count).to eq(1)
		end
	end
end

