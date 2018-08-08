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

end