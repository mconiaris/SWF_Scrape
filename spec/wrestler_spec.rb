RSpec.describe Wrestler do
	before(:context) do
		scrape = Scraper.new("files/Zak Knight.pdf")
		binding.pry
		@wrestler = Wrestler.new(scrape.card)
	end

	describe "Wrestler initialized in before(:context)" do
  	it "has a key value pair of name: Zak Knight" do
    	expect(@wrestler.name).to eq('Zak Knight')
    end
  end
end