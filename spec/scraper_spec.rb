RSpec.describe Scraper do
	before(:context) do
		@reader = PDF::Reader.new("files/Zak Knight.pdf")
	end
	
	describe 'Scraper' do
		context 'Zak Knight PDF' do
			it "should have one page" do
				expect(@reader.page_count).to eq(1)
			end
		end
	end
end

