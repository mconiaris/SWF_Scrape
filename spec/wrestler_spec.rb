require 'pdf-reader'
require 'pry'
require 'wrestler'

# Main Spec
RSpec.describe Wrestler do
	context 'initialize' do
		it 'creates an object of it\'s class' do
			wrestler = Wrestler.new
			expect(described_class).to eq(Wrestler)
		end
	end
end