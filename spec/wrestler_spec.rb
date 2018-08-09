require 'pdf-reader'
require 'pry'
require 'wrestler'

# Main Spec
RSpec.describe Wrestler do
	before(:example) do
		wrestler = Wrestler.new
	end

	context 'initialize' do
		it 'creates an object of it\'s class' do
			expect(described_class).to eq(Wrestler)
		end
	end
end