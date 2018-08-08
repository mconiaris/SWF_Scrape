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

describe 'PDF Reader' do
	it 'loads the Zak Knight PDF as a Reader file' do
		reader = PDF::Reader.new("files/Zak Knight.pdf")
		expect(reader.class).to eql(PDF::Reader)
	end
end