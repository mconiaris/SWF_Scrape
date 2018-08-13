require 'pdf-reader'
require 'pry'
require 'wrestler'

# Main Spec
RSpec.describe Wrestler do
	before(:example) do
		@wrestler = Wrestler.new
		puts 'before block executes.'
	end

	describe '#initialize' do
		it 'creates an object of it\'s class' do
			expect(described_class).to eq(Wrestler)
		end
		it 'has a name value of nil' do
			expect(@wrestler.get_name).to eq(nil)
		end
	end

end