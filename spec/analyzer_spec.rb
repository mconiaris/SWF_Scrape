RSpec.describe Analyzer do
	before(:context) do
		@analyze = Analyzer.new
	end

	describe '#analyze_gc' do
		it "should respond_to analyze_gc" do
			expect(@analyze.respond_to?(:analyze_gc))
		end
	end

	describe '#analyze_s' do
		it "should respond_to analyze_s" do
			expect(@analyze.respond_to?(:analyze_s))
		end
	end

	# TODO: Make tests to confirm math is right.
end