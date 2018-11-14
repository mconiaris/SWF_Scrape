RSpec.describe Wrestler do
	before(:context) do
		scrape = Scraper.new("files/Zak Knight.pdf")
		card = scrape.card
		hashed_card = scrape.process_card(card)
		@wrestler = Wrestler.new(hashed_card)
	end

	# TODO: Make this test pass.
	describe "Wrestler#initialize when passed the Zak Knight card" do
  	it "has a key value pair of name: Zak Knight" do
    	expect(@wrestler.values[:name]).to eq('Zak Knight')
    end
  end
end