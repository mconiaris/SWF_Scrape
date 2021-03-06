RSpec.describe Wrestler do
	before(:context) do
		scrape = Scraper.new("files/Zak Knight.pdf")
		card = scrape.card
		hashed_card = scrape.process_card(card)
		@wrestler = Wrestler.new(hashed_card)
	end

	context 'when the Zak Knight card passed as an argument' do
		describe "#initialize" do
	  	it 'creates an instance of a Wrestler object' do
	  		expect(@wrestler).to be_an_instance_of(Wrestler)
	  	end
	  	it "has a key value pair of name: Zak Knight" do
	    	expect(@wrestler.values[:name]).to eq('Zak Knight')
	    end
	  end
	end

end