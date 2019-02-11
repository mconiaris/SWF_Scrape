# TODO: Use Let with context nested into it.
# TODO: Run rspec --profile 2 to test tests.

# TODO: Fix let syntax. All of the tests are breaking.
RSpec.describe Analyzer do
	let(:analyze) { Analyzer.new }

	describe '#initialize' do
		context 'after initialization' do
			it "should create an empty @statistics hash" do
				expect(analyze.statistics).to be_instance_of(Hash)
			end
			it "should create a variable that will respond_to #analyze_gc" do
				expect(analyze.respond_to?(:analyze_gc))
			end
			it "should create a variable that will respond_to analyze_dc" do
				expect(analyze.respond_to?(:analyze_dc))
			end
			it "should create a variable that will respond_to analyze_s" do
				expect(analyze.respond_to?(:analyze_s))
			end
			it "should create a variable that will respond_to submission_probability" do
				expect(analyze.respond_to?(:submission_probability))
			end
			it "should create a variable that will respond_to offense_points" do
				expect(analyze.respond_to?(:offense_points))
			end
		end
	end

	describe '#calculate_probility' do
		context 'when when \'OC02\' is passed' do
			it 'should return 1/36.to_r' do
				expect(analyze.calculate_probability('OC02')).to eq(1/36.to_r)
			end
		end
		context 'when \'OC03\' is passed' do
			it 'should return 2/36.to_r' do
				expect(analyze.calculate_probability('OC03')).to eq(2/36.to_r)
			end
		end
		context 'when \'OC04\' is passed' do
			it 'should return 3/36.to_r' do
				expect(analyze.calculate_probability('OC04')).to eq(3/36.to_r)
			end
		end
		context 'when \'OC05\' is passed' do
			it 'should return 4/36.to_r' do
				expect(analyze.calculate_probability('OC05')).to eq(4/36.to_r)
			end
		end
		context 'when \'OC06\' is passed' do
			it 'should return 5/36.to_r' do
				expect(analyze.calculate_probability('OC06')).to eq(5/36.to_r)
			end
		end
		context 'when \'OC07\' is passed' do
			it 'should return 6/36.to_r' do
				expect(analyze.calculate_probability('OC07')).to eq(6/36.to_r)
			end
		end
		context 'when \'OC08\' is passed' do
			it 'should return 5/36.to_r' do
				expect(analyze.calculate_probability('OC08')).to eq(5/36.to_r)
			end
		end
		context 'when \'OC09\' is passed' do
			it 'should return 4/36.to_r' do
				expect(analyze.calculate_probability('OC09')).to eq(4/36.to_r)
			end
		end
		context 'when \'OC10\' is passed' do
			it 'should return 3/36.to_r' do
				expect(analyze.calculate_probability('OC10')).to eq(3/36.to_r)
			end
		end
		context 'when \'OC11\' is passed' do
			it 'should return 2/36.to_r' do
				expect(analyze.calculate_probability('OC11')).to eq(2/36.to_r)
			end
		end
		context 'when \'OC12\' is passed' do
			it 'should return 1/36.to_r' do
				expect(analyze.calculate_probability('OC12')).to eq(1/36.to_r)
			end
		end
	end

	describe '#calculate_gc_oc_roll_probability' do
		it 'should return 1/36.to_r when GC02 and OC is passed' do
			expect(analyze.calculate_gc_oc_roll_probability('GC02', 'OC')).to eq(1/36.to_r)
		end
		it 'should return 2/36.to_r when GC03 and OC is passed' do
			expect(analyze.calculate_gc_oc_roll_probability('GC03', 'OC')).to eq(2/36.to_r)
		end
		it 'should return 3/36.to_r when GC04 and OC is passed' do
			expect(analyze.calculate_gc_oc_roll_probability('GC04', 'OC')).to eq(3/36.to_r)
		end
		it 'should return 4/36.to_r when GC05 and OC is passed' do
			expect(analyze.calculate_gc_oc_roll_probability('GC05', 'OC')).to eq(4/36.to_r)
		end
		it 'should return 5/36.to_r when GC06 and OC is passed' do
			expect(analyze.calculate_gc_oc_roll_probability('GC06', 'OC')).to eq(5/36.to_r)
		end
		it 'should return 6/36.to_r when GC07 and OC is passed' do
			expect(analyze.calculate_gc_oc_roll_probability('GC07', 'OC')).to eq(6/36.to_r)
		end
		it 'should return 5/36.to_r when GC08 and OC is passed' do
			expect(analyze.calculate_gc_oc_roll_probability('GC08', 'OC')).to eq(5/36.to_r)
		end
		it 'should return 4/36.to_r when GC09 and OC is passed' do
			expect(analyze.calculate_gc_oc_roll_probability('GC09', 'OC')).to eq(4/36.to_r)
		end
		it 'should return 3/36.to_r when GC10 and OC is passed' do
			expect(analyze.calculate_gc_oc_roll_probability('GC10', 'OC')).to eq(3/36.to_r)
		end
		it 'should return 2/36.to_r when GC11 and OC is passed' do
			expect(analyze.calculate_gc_oc_roll_probability('GC11', 'OC')).to eq(2/36.to_r)
		end
		it 'should return 1/36.to_r when GC12 and OC is passed' do
			expect(analyze.calculate_gc_oc_roll_probability('GC02', 'OC')).to eq(1/36.to_r)
		end
		it 'should return 1/36.to_r when GC02 and OC is passed' do
			expect(analyze.calculate_gc_oc_roll_probability('GC12', 'OC')).to eq(1/36.to_r)
		end
		it 'should return 0 when GC02 and DC is passed' do
			expect(analyze.calculate_gc_oc_roll_probability('GC02', 'DC')).to eq(0)
		end
		it 'should return 0 when GC03 and DC is passed' do
			expect(analyze.calculate_gc_oc_roll_probability('GC03', 'DC')).to eq(0)
		end
		it 'should return 0 when GC04 and DC is passed' do
			expect(analyze.calculate_gc_oc_roll_probability('GC04', 'DC')).to eq(0)
		end
		it 'should return 0 when GC05 and DC is passed' do
			expect(analyze.calculate_gc_oc_roll_probability('GC05', 'DC')).to eq(0)
		end
		it 'should return 0 when GC06 and DC is passed' do
			expect(analyze.calculate_gc_oc_roll_probability('GC06', 'DC')).to eq(0)
		end
		it 'should return 0 when GC07 and DC is passed' do
			expect(analyze.calculate_gc_oc_roll_probability('GC07', 'DC')).to eq(0)
		end
		it 'should return 0 when GC08 and DC is passed' do
			expect(analyze.calculate_gc_oc_roll_probability('GC08', 'DC')).to eq(0)
		end
		it 'should return 0 when GC09 and DC is passed' do
			expect(analyze.calculate_gc_oc_roll_probability('GC09', 'DC')).to eq(0)
		end
		it 'should return 0 when GC10 and DC is passed' do
			expect(analyze.calculate_gc_oc_roll_probability('GC10', 'DC')).to eq(0)
		end
		it 'should return 0 when GC11 and DC is passed' do
			expect(analyze.calculate_gc_oc_roll_probability('GC11', 'DC')).to eq(0)
		end
		it 'should return 0 when GC12 and DC is passed' do
			expect(analyze.calculate_gc_oc_roll_probability('GC12', 'DC')).to eq(0)
		end
	end

	# return 36/36.to_r - oc_roll_probability
	describe '#calculate_gc_dc_roll_probability' do
		it 'should return 36/36 when a OC of 0/36 is passed' do
			oc_prob = 0/36.to_r
			expect(analyze.calculate_gc_dc_roll_probability(oc_prob)).to eq(36/36.to_r)
		end
		it 'should return 35/36 when a OC of 1/36 is passed' do
			oc_prob = 1/36.to_r
			expect(analyze.calculate_gc_dc_roll_probability(oc_prob)).to eq(35/36.to_r)
		end
		it 'should return 33/36 when a OC of 3/36 is passed' do
			oc_prob = 3/36.to_r
			expect(analyze.calculate_gc_dc_roll_probability(oc_prob)).to eq(33/36.to_r)
		end
		it 'should return 30/36 when a OC of 6/36 is passed' do
			oc_prob = 6/36.to_r
			expect(analyze.calculate_gc_dc_roll_probability(oc_prob)).to eq(30/36.to_r)
		end
		it 'should return 26/36 when a OC of 10/36 is passed' do
			oc_prob = 10/36.to_r
			expect(analyze.calculate_gc_dc_roll_probability(oc_prob)).to eq(26/36.to_r)
		end
		it 'should return 21/36 when a OC of 15/36 is passed' do
			oc_prob = 15/36.to_r
			expect(analyze.calculate_gc_dc_roll_probability(oc_prob)).to eq(21/36.to_r)
		end
		it 'should return 25/36 when a OC of 21/36 is passed' do
			oc_prob = 21/36.to_r
			expect(analyze.calculate_gc_dc_roll_probability(oc_prob)).to eq(15/36.to_r)
		end
		it 'should return 10/36 when a OC of 26/36 is passed' do
			oc_prob = 26/36.to_r
			expect(analyze.calculate_gc_dc_roll_probability(oc_prob)).to eq(10/36.to_r)
		end
		it 'should return 6/36 when a OC of 30/36 is passed' do
			oc_prob = 30/36.to_r
			expect(analyze.calculate_gc_dc_roll_probability(oc_prob)).to eq(6/36.to_r)
		end
		it 'should return 3/36 when a OC of 33/36 is passed' do
			oc_prob = 33/36.to_r
			expect(analyze.calculate_gc_dc_roll_probability(oc_prob)).to eq(3/36.to_r)
		end
		it 'should return 1/36 when a OC of 35/36 is passed' do
			oc_prob = 35/36.to_r
			expect(analyze.calculate_gc_dc_roll_probability(oc_prob)).to eq(1/36.to_r)
		end
		it 'should return 0/36 when a OC of 36/36 is passed' do
			oc_prob = 36/36.to_r
			expect(analyze.calculate_gc_dc_roll_probability(oc_prob)).to eq(0/36.to_r)
		end
	end

	# calculate_gc_tt_roll_probability(wrestler_hash)
	describe '#calculate_gc_tt_roll_probability' do
		it 'should return (0/36) when a no values of \'OC/TT\' are passed' do
			wrestler_hash = { :GC05 => 'OC', :GC06 => 'DC', :GC07 => 'OC', :GC08 => 'OC' }
			expect(analyze.calculate_gc_tt_roll_probability(wrestler_hash)).to eq(0/36.to_r)
		end
		it 'should return (1/36) when a \':GC02 => \'OC/TT\'\' is passed' do
			wrestler_hash = { :GC02 => 'OC/TT', :GC05 => 'OC', :GC06 => 'DC', :GC07 => 'OC', :GC08 => 'OC' }
			expect(analyze.calculate_gc_tt_roll_probability(wrestler_hash)).to eq(1/36.to_r)
		end
		it 'should return (2/36) when a \':GC03 => \'OC/TT\'\' is passed' do
			wrestler_hash = { :GC03 => 'OC/TT', :GC05 => 'OC', :GC06 => 'DC', :GC07 => 'OC', :GC08 => 'OC' }
			expect(analyze.calculate_gc_tt_roll_probability(wrestler_hash)).to eq(2/36.to_r)
		end
		it 'should return (3/36) when a \':GC04 => \'OC/TT\'\' is passed' do
			wrestler_hash = { :GC04 => 'OC/TT', :GC05 => 'OC', :GC06 => 'DC', :GC07 => 'OC', :GC08 => 'OC' }
			expect(analyze.calculate_gc_tt_roll_probability(wrestler_hash)).to eq(3/36.to_r)
		end
		it 'should return (4/36) when a \':GC05 => \'OC/TT\'\' is passed' do
			wrestler_hash = { :GC05 => 'OC/TT', :GC06 => 'DC', :GC07 => 'OC', :GC08 => 'OC', :GC09 => 'OC' }
			expect(analyze.calculate_gc_tt_roll_probability(wrestler_hash)).to eq(4/36.to_r)
		end
		it 'should return (5/36) when a \':GC06 => \'OC/TT\'\' is passed' do
			wrestler_hash = { :GC05 => 'OC', :GC06 => 'OC/TT', :GC07 => 'OC', :GC08 => 'OC', :GC09 => 'OC' }
			expect(analyze.calculate_gc_tt_roll_probability(wrestler_hash)).to eq(5/36.to_r)
		end
		it 'should return (6/36) when a \':GC07 => \'OC/TT\'\' is passed' do
			wrestler_hash = { :GC05 => 'OC', :GC06 => 'DC', :GC07 => 'OC/TT', :GC08 => 'OC', :GC09 => 'OC' }
			expect(analyze.calculate_gc_tt_roll_probability(wrestler_hash)).to eq(6/36.to_r)
		end
		it 'should return (5/36) when a \':GC08 => \'OC/TT\'\' is passed' do
			wrestler_hash = { :GC05 => 'OC', :GC06 => 'DC', :GC07 => 'OC', :GC08 => 'OC/TT', :GC09 => 'OC' }
			expect(analyze.calculate_gc_tt_roll_probability(wrestler_hash)).to eq(5/36.to_r)
		end
		it 'should return (4/36) when a \':GC09 => \'OC/TT\'\' is passed' do
			wrestler_hash = { :GC05 => 'OC', :GC06 => 'DC', :GC07 => 'OC', :GC08 => 'OC', :GC09 => 'OC/TT' }
			expect(analyze.calculate_gc_tt_roll_probability(wrestler_hash)).to eq(4/36.to_r)
		end
		it 'should return (3/36) when a \':GC10 => \'OC/TT\'\' is passed' do
			wrestler_hash = { :GC08 => 'OC', :GC09 => 'DC', :GC10 => 'OC/TT', :GC11 => 'OC', :GC12 => 'OC' }
			expect(analyze.calculate_gc_tt_roll_probability(wrestler_hash)).to eq(3/36.to_r)
		end
		it 'should return (2/36) when a \':GC11 => \'OC/TT\'\' is passed' do
			wrestler_hash = { :GC08 => 'OC', :GC09 => 'DC', :GC10 => 'OC', :GC11 => 'OC/TT', :GC12 => 'OC' }
			expect(analyze.calculate_gc_tt_roll_probability(wrestler_hash)).to eq(2/36.to_r)
		end
		it 'should return (1/36) when a \':GC12 => \'OC/TT\'\' is passed' do
			wrestler_hash = { :GC08 => 'OC', :GC09 => 'DC', :GC10 => 'OC', :GC11 => 'OC', :GC12 => 'OC/TT' }
			expect(analyze.calculate_gc_tt_roll_probability(wrestler_hash)).to eq(1/36.to_r)
		end
	end

	# TODO: Wrap when X is passed into context blocks for above examples.

	# calculate_reverse_roll_probability(wrestler_hash, gc_dc_roll_probability)
	describe '#calculate_reverse_roll_probability' do
	end


	# TODO: Make tests to confirm math is right.
	# TODO: Create test that deals with DQs in Specialty moves.
	# TODO: Create unit tests for calculate_probility method"
	# TODO: Create unit tests for calculate_gc_oc_roll_probability
	

end