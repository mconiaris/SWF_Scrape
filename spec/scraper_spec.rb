RSpec.describe Scraper do
	before(:context) do
		@scrape = Scraper.new("files/Zak Knight.pdf")
	end
	
	context 'when the Zak Knight PDF is given as an argument' do
		describe 'Scraper#initialize' do
			it "should have one page" do
				expect(@scrape.reader.page_count).to eq(1)
			end
			it "should have 1469 characters" do
				expect(@scrape.reader.page(1).text.size).to eq(1469)
			end
			it "should include 'Zak Knight' in the text." do
				expect(@scrape.reader.page(1).text).to include("Zak Knight")
			end
			it 'should have Zak Knight in the first line' do
				expect(@scrape.card[0].include?('Zak Knight')).to eq(true)
			end
		end

		describe 'Scraper#process_card' do
			it 'responds to #process_card method' do
				expect(@scrape.respond_to?(:process_card)).to eq(true)
			end
			it 'returns a hash' do
				card = @scrape.card
				expect(@scrape.process_card(card)).to be_kind_of(Hash)
			end
			it 'includes a :name property that is \'Zak Knight\'' do
				card = @scrape.card
				result = @scrape.process_card(card)
				expect(result[:name]).to eq("Zak Knight")
			end
		end
	end
end

