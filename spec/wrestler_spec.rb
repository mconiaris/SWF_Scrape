require 'pdf-reader'
require 'pry'
require 'wrestler'

# Main Spec
describe Wrestler do
	describe 'can be initialized' do
		it 'with no name' do
			wrestler = Wrestler.new
			expect(wrestler.get_name).to eql(nil)
		end
	end
end

# TODO: Fix structure of rspec test so that one test builds
# on another.
describe 'PDF Reader' do
	it 'loads the Zak Knight PDF as a Reader file' do
		reader = PDF::Reader.new("files/Zak Knight.pdf")
		expect(reader.class).to eql(PDF::Reader)
	end
	describe 'Zak Knight file' do
		it 'reader.pages[0].text returns text as a String' do
			wrestler_text = reader.pages[0].text
			expect(wrestler_text.class).to eql(String)
		binding.pry
		end
	end
end