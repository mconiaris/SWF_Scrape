RSpec.describe Analyzer do
	before(:context) do
		@analyze = Analyzer.new
	end

	context 'when initialized' do
		describe '#initialize' do
			it "should create an empty @statistics hash" do
				expect(@analyze.statistics).to be_instance_of(Hash)
			end
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

		describe '#offense_points' do
			it "should respond_to offense_points" do
				expect(@analyze.respond_to?(:offense_points))
			end
		end

		describe '#analyze @statistics' do
			it 'should return a hash' do
				expect(@analyze.statistics.class).instance_of?(Hash)
			end
		end

		# Fix logic
		describe '#calculate_probility' do
			it 'should return 1/36 when \'OC02\' is passed to it' do
				binding.pry
				expect(@analyze.calculate_probability('OC02')).to eq(1/36)
			end
		end
	end



	# TODO: Make tests to confirm math is right.
	# TODO: Create test that deals with DQs in Specialty moves.
	# TODO: Create unit tests for calculate_probility method"
	# TODO: Create unit tests for calculate_gc_oc_roll_probability
	

end