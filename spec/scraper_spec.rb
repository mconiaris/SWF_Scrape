RSpec.describe Scraper do
	before(:context) do
		@scrape = Scraper.new("files/Zak Knight.pdf")
	end
	
	describe 'Scraper#initialize' do
		context 'when the Zak Knight PDF is given as an argument' do
			it "should have one page" do
				expect(@scrape.reader.page_count).to eq(1)
			end
			describe '#reader' do
			end
			it "should have 1469 characters" do
				expect(@scrape.reader.page(1).text.size).to eq(1469)
			end
			it "should include 'Zak Knight' in the text." do
				expect(@scrape.reader.page(1).text).to include("Zak Knight")
			end
			it "should respond to the capture_text method" do
				expect(@scrape.respond_to?(:capture_text)).to eq(true)
			end
			it 'should have Zak Knight in the first line' do
				@card = @scrape.reader.page(1).text
				expect(@card.include?('Zak Knight')).to eq(true)
			end
		end
	end
end

