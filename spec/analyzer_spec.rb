# TODO: Use Let with context nested into it.
# TODO: Run rspec --profile 2 to test tests.

# TODO: Fix let syntax. All of the tests are breaking.
RSpec.describe Analyzer do
	let(:analyze) { Analyzer.new }

	# before(:context) do
	# 	@analyze = Analyzer.new
	# end

	context 'when initialized' do
		binding.pry
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

		describe '#calculate_probility' do
			it 'should return 1/36.to_r when \'OC02\' is passed to it' do
				expect(@analyze.calculate_probability('OC02')).to eq(1/36.to_r)
			end
			it 'should return 2/36.to_r when \'OC03\' is passed to it' do
				expect(@analyze.calculate_probability('OC03')).to eq(2/36.to_r)
			end
			it 'should return 3/36.to_r when \'OC04\' is passed to it' do
				expect(@analyze.calculate_probability('OC04')).to eq(3/36.to_r)
			end
			it 'should return 4/36.to_r when \'OC05\' is passed to it' do
				expect(@analyze.calculate_probability('OC05')).to eq(4/36.to_r)
			end
			it 'should return 5/36.to_r when \'OC06\' is passed to it' do
				expect(@analyze.calculate_probability('OC06')).to eq(5/36.to_r)
			end
			it 'should return 6/36.to_r when \'OC07\' is passed to it' do
				expect(@analyze.calculate_probability('OC07')).to eq(6/36.to_r)
			end
			it 'should return 5/36.to_r when \'OC08\' is passed to it' do
				expect(@analyze.calculate_probability('OC08')).to eq(5/36.to_r)
			end
			it 'should return 4/36.to_r when \'OC09\' is passed to it' do
				expect(@analyze.calculate_probability('OC09')).to eq(4/36.to_r)
			end
			it 'should return 3/36.to_r when \'OC10\' is passed to it' do
				expect(@analyze.calculate_probability('OC10')).to eq(3/36.to_r)
			end
			it 'should return 2/36.to_r when \'OC11\' is passed to it' do
				expect(@analyze.calculate_probability('OC11')).to eq(2/36.to_r)
			end
			it 'should return 1/36.to_r when \'OC12\' is passed to it' do
				expect(@analyze.calculate_probability('OC12')).to eq(1/36.to_r)
			end
		end

		describe '#calculate_gc_oc_roll_probability' do
			it 'should return 1/36.to_r when GC02 and OC is passed' do
				expect(@analyze.calculate_gc_oc_roll_probability('GC02', 'OC')).to eq(1/36.to_r)
			end
			it 'should return 2/36.to_r when GC03 and OC is passed' do
				expect(@analyze.calculate_gc_oc_roll_probability('GC03', 'OC')).to eq(2/36.to_r)
			end
			it 'should return 3/36.to_r when GC04 and OC is passed' do
				expect(@analyze.calculate_gc_oc_roll_probability('GC04', 'OC')).to eq(3/36.to_r)
			end
			it 'should return 4/36.to_r when GC05 and OC is passed' do
				expect(@analyze.calculate_gc_oc_roll_probability('GC05', 'OC')).to eq(4/36.to_r)
			end
			it 'should return 5/36.to_r when GC06 and OC is passed' do
				expect(@analyze.calculate_gc_oc_roll_probability('GC06', 'OC')).to eq(5/36.to_r)
			end
			it 'should return 6/36.to_r when GC07 and OC is passed' do
				expect(@analyze.calculate_gc_oc_roll_probability('GC07', 'OC')).to eq(6/36.to_r)
			end
			it 'should return 5/36.to_r when GC08 and OC is passed' do
				expect(@analyze.calculate_gc_oc_roll_probability('GC08', 'OC')).to eq(5/36.to_r)
			end
			it 'should return 4/36.to_r when GC09 and OC is passed' do
				expect(@analyze.calculate_gc_oc_roll_probability('GC09', 'OC')).to eq(4/36.to_r)
			end
			it 'should return 3/36.to_r when GC10 and OC is passed' do
				expect(@analyze.calculate_gc_oc_roll_probability('GC10', 'OC')).to eq(3/36.to_r)
			end
			it 'should return 2/36.to_r when GC11 and OC is passed' do
				expect(@analyze.calculate_gc_oc_roll_probability('GC11', 'OC')).to eq(2/36.to_r)
			end
			it 'should return 1/36.to_r when GC12 and OC is passed' do
				expect(@analyze.calculate_gc_oc_roll_probability('GC02', 'OC')).to eq(1/36.to_r)
			end
			it 'should return 1/36.to_r when GC02 and OC is passed' do
				expect(@analyze.calculate_gc_oc_roll_probability('GC12', 'OC')).to eq(1/36.to_r)
			end
			it 'should return 0 when GC02 and DC is passed' do
				expect(@analyze.calculate_gc_oc_roll_probability('GC02', 'DC')).to eq(0)
			end
			it 'should return 0 when GC03 and DC is passed' do
				expect(@analyze.calculate_gc_oc_roll_probability('GC03', 'DC')).to eq(0)
			end
			it 'should return 0 when GC04 and DC is passed' do
				expect(@analyze.calculate_gc_oc_roll_probability('GC04', 'DC')).to eq(0)
			end
			it 'should return 0 when GC05 and DC is passed' do
				expect(@analyze.calculate_gc_oc_roll_probability('GC05', 'DC')).to eq(0)
			end
			it 'should return 0 when GC06 and DC is passed' do
				expect(@analyze.calculate_gc_oc_roll_probability('GC06', 'DC')).to eq(0)
			end
			it 'should return 0 when GC07 and DC is passed' do
				expect(@analyze.calculate_gc_oc_roll_probability('GC07', 'DC')).to eq(0)
			end
			it 'should return 0 when GC08 and DC is passed' do
				expect(@analyze.calculate_gc_oc_roll_probability('GC08', 'DC')).to eq(0)
			end
			it 'should return 0 when GC09 and DC is passed' do
				expect(@analyze.calculate_gc_oc_roll_probability('GC09', 'DC')).to eq(0)
			end
			it 'should return 0 when GC10 and DC is passed' do
				expect(@analyze.calculate_gc_oc_roll_probability('GC10', 'DC')).to eq(0)
			end
			it 'should return 0 when GC11 and DC is passed' do
				expect(@analyze.calculate_gc_oc_roll_probability('GC11', 'DC')).to eq(0)
			end
			it 'should return 0 when GC12 and DC is passed' do
				expect(@analyze.calculate_gc_oc_roll_probability('GC12', 'DC')).to eq(0)
			end
		end
	end



	# TODO: Make tests to confirm math is right.
	# TODO: Create test that deals with DQs in Specialty moves.
	# TODO: Create unit tests for calculate_probility method"
	# TODO: Create unit tests for calculate_gc_oc_roll_probability
	

end