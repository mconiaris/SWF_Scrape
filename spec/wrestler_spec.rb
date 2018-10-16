# Main Spec
RSpec.describe Wrestler do
	before(:example) do
		@wrestler = Wrestler.new
	end

	describe '#initialize' do
		it 'creates an object of it\'s class' do
			expect(described_class).to eq(Wrestler)
		end
		it 'that has a name value of nil' do
			expect(@wrestler.get_name).to eq(nil)
		end
		it 'responds to #get_name method' do
			expect(@wrestler.respond_to?(:get_name)).to eq(true)
		end
		it 'responds to #set_name' do
			expect(@wrestler.respond_to?(:set_name)).to eq(true)
		end
		it 'responds to #set_file_name' do
			expect(@wrestler.respond_to?(:set_file_name)).to eq(true)
		end
		it 'responds to #process_offense' do
			expect(@wrestler.respond_to?(:process_offense)).to eq(true)
		end
		it 'responds to #process_defense' do
			expect(@wrestler.respond_to?(:process_defense)).to eq(true)
		end
		# process_text
		it 'responds to #process_text' do
			expect(@wrestler.respond_to?(:process_text)).to eq(true)
			# binding.pry
		end
		it 'responds to #process_source' do
			expect(@wrestler.respond_to?(:process_source)).to eq(true)
		end
	end

	context '#process_source' do

		before(:context) do
			@wrestler = Wrestler.new
			# binding.pry
		end



		# after(:context) do
		# 	# binding.pry
		# 	@wrestler_text = @wrestler.pdf_to_text("files/Zak Knight.pdf")
		# end

		it 'turns a PDF into text' do
			# binding.pry
			wrestler_text = @wrestler.process_source("files/Zak Knight.pdf")
			pending
		end
	end
end