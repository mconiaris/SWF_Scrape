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
		it 'that has a name value of nil' do
			expect(@wrestler.get_name).to eq(nil)
		end
		it 'that has a get_name method' do
			expect(@wrestler.respond_to?(:get_name)).to eq(true)
		end
		it 'that has a set_name method' do
			expect(@wrestler.respond_to?(:set_name)).to eq(true)
		end
		it 'that has a set_file_name method' do
			expect(@wrestler.respond_to?(:set_file_name)).to eq(true)
		end
		it 'that has a process_offense method' do
			expect(@wrestler.respond_to?(:process_offense)).to eq(true)
		end
		it 'that has a process_defense method' do
			expect(@wrestler.respond_to?(:process_defense)).to eq(true)
		end
		# process_text
		it 'that has a process_text method' do
			expect(@wrestler.respond_to?(:process_text)).to eq(true)
		end
	end

end