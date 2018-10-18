RSpec.describe Scraper do
	before(:context) do
		@scrape = Scraper.new("files/Zak Knight.pdf")
	end
	
	describe '#initialize' do
		context 'Zak Knight PDF' do
			it "should have one page" do
				expect(@scrape.reader.page_count).to eq(1)
			end
		end
	end
end

