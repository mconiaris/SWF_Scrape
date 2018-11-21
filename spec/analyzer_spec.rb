RSpec.describe Analyzer do
	before(:context) do
		@analyze = Analyzer.new
	end

	describe '#analyze_gc' do
		it "should respond_to analyze_gc" do
			expect(@analyze.respond_to?(:analyze_gc))
		end
	end

	describe '#analyze_dc' do
		it "should respond_to analyze_dc" do
			expect(@analyze.respond_to?(:analyze_dc))
		end
	end

	describe '#analyze_s' do
		it "should respond_to analyze_s" do
			expect(@analyze.respond_to?(:analyze_s))
		end
	end

	describe '#submission_probability' do
		it "should respond_to submission_probability" do
			expect(@analyze.respond_to?(:submission_probability))
		end
	end

	# TODO: Make tests to confirm math is right.
	# TODO: Create test that deals with DQs in Specialty moves.

end