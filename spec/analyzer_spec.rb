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
		context 'when GC02 and OC is passed' do
			it 'should return 1/36.to_r' do
				expect(analyze.calculate_gc_oc_roll_probability('GC02', 'OC')).to eq(1/36.to_r)
			end
		end
		context 'when GC03 and OC is passed' do
			it 'should return 2/36.to_r' do
				expect(analyze.calculate_gc_oc_roll_probability('GC03', 'OC')).to eq(2/36.to_r)
			end
		end
		context 'when GC04 and OC is passed' do
			it 'should return 3/36.to_r' do
				expect(analyze.calculate_gc_oc_roll_probability('GC04', 'OC')).to eq(3/36.to_r)
			end
		end
		context 'when GC05 and OC is passed' do
			it 'should return 4/36.to_r' do
				expect(analyze.calculate_gc_oc_roll_probability('GC05', 'OC')).to eq(4/36.to_r)
			end
		end
		context 'when GC06 and OC is passed' do
			it 'should return 5/36.to_r' do
				expect(analyze.calculate_gc_oc_roll_probability('GC06', 'OC')).to eq(5/36.to_r)
			end
		end
		context 'when GC07 and OC is passed' do
			it 'should return 6/36.to_r' do
				expect(analyze.calculate_gc_oc_roll_probability('GC07', 'OC')).to eq(6/36.to_r)
			end
		end
		context 'when GC08 and OC is passed' do
			it 'should return 5/36.to_r' do
				expect(analyze.calculate_gc_oc_roll_probability('GC08', 'OC')).to eq(5/36.to_r)
			end
		end
		context 'when GC09 and OC is passed' do
			it 'should return 4/36.to_r ' do
				expect(analyze.calculate_gc_oc_roll_probability('GC09', 'OC')).to eq(4/36.to_r)
			end
		end
		context 'when GC10 and OC is passed' do
			it 'should return 3/36.to_r' do
				expect(analyze.calculate_gc_oc_roll_probability('GC10', 'OC')).to eq(3/36.to_r)
			end
		end
		context 'when GC11 and OC is passed' do
			it 'should return 2/36.to_r' do
				expect(analyze.calculate_gc_oc_roll_probability('GC11', 'OC')).to eq(2/36.to_r)
			end
		end
		context 'when GC12 and OC is passed' do
			it 'should return 1/36.to_r' do
				expect(analyze.calculate_gc_oc_roll_probability('GC12', 'OC')).to eq(1/36.to_r)
			end
		end
		context 'when GC02 and DC is passed' do
			it 'should return 0' do
				expect(analyze.calculate_gc_oc_roll_probability('GC02', 'DC')).to eq(0)
			end
		end
		context 'when GC03 and DC is passed' do
			it 'should return 0' do
				expect(analyze.calculate_gc_oc_roll_probability('GC03', 'DC')).to eq(0)
			end
		end
		context 'when GC04 and DC is passed' do
			it 'should return 0' do
				expect(analyze.calculate_gc_oc_roll_probability('GC04', 'DC')).to eq(0)
			end
		end
		context 'when GC05 and DC is passed' do
			it 'should return 0' do
				expect(analyze.calculate_gc_oc_roll_probability('GC05', 'DC')).to eq(0)
			end
		end
		context 'when GC06 and DC is passed' do
			it 'should return 0' do
				expect(analyze.calculate_gc_oc_roll_probability('GC06', 'DC')).to eq(0)
			end
		end
		context 'when GC07 and DC is passed' do
			it 'should return 0' do
				expect(analyze.calculate_gc_oc_roll_probability('GC07', 'DC')).to eq(0)
			end
		end
		context 'when GC08 and DC is passed' do
			it 'should return 0' do
				expect(analyze.calculate_gc_oc_roll_probability('GC08', 'DC')).to eq(0)
			end
		end
		context 'when GC09 and DC is passed' do
			it 'should return 0' do
				expect(analyze.calculate_gc_oc_roll_probability('GC09', 'DC')).to eq(0)
			end
		end
		context 'when GC10 and DC is passed' do
			it 'should return 0' do
				expect(analyze.calculate_gc_oc_roll_probability('GC10', 'DC')).to eq(0)
			end
		end
		context 'when GC11 and DC is passed' do
			it 'should return 0' do
				expect(analyze.calculate_gc_oc_roll_probability('GC11', 'DC')).to eq(0)
			end
		end
		context 'when GC12 and DC is passed' do
			it 'should return 0' do
				expect(analyze.calculate_gc_oc_roll_probability('GC12', 'DC')).to eq(0)
			end
		end
	end

	# return 36/36.to_r - oc_roll_probability
	describe '#calculate_gc_dc_roll_probability' do
		context 'when a OC of 0/36 is passed' do
			it 'should return 36/36' do
				oc_prob = 0/36.to_r
				expect(analyze.calculate_gc_dc_roll_probability(oc_prob)).to eq(36/36.to_r)
			end
		end
		context 'when a OC of 1/36 is passed' do
			it 'should return 35/36' do
				oc_prob = 1/36.to_r
				expect(analyze.calculate_gc_dc_roll_probability(oc_prob)).to eq(35/36.to_r)
			end
		end
		context 'when a OC of 3/36 is passed' do
			it 'should return 33/36' do
				oc_prob = 3/36.to_r
				expect(analyze.calculate_gc_dc_roll_probability(oc_prob)).to eq(33/36.to_r)
			end
		end
		context 'when a OC of 6/36 is passed' do
			it 'should return 30/36' do
				oc_prob = 6/36.to_r
				expect(analyze.calculate_gc_dc_roll_probability(oc_prob)).to eq(30/36.to_r)
			end
		end
		context 'when a OC of 10/36 is passed' do
			it 'should return 26/36' do
				oc_prob = 10/36.to_r
				expect(analyze.calculate_gc_dc_roll_probability(oc_prob)).to eq(26/36.to_r)
			end
		end
		context 'when a OC of 15/36 is passed' do
			it 'should return 21/36' do
				oc_prob = 15/36.to_r
				expect(analyze.calculate_gc_dc_roll_probability(oc_prob)).to eq(21/36.to_r)
			end
		end
		context 'when a OC of 21/36 is passed' do
			it 'should return 25/36' do
				oc_prob = 21/36.to_r
				expect(analyze.calculate_gc_dc_roll_probability(oc_prob)).to eq(15/36.to_r)
			end
		end
		context 'when a OC of 26/36 is passed' do
			it 'should return 10/36 ' do
				oc_prob = 26/36.to_r
				expect(analyze.calculate_gc_dc_roll_probability(oc_prob)).to eq(10/36.to_r)
			end
		end
		context 'when a OC of 30/36 is passed' do
			it 'should return 6/36' do
				oc_prob = 30/36.to_r
				expect(analyze.calculate_gc_dc_roll_probability(oc_prob)).to eq(6/36.to_r)
			end
		end
		context 'when a OC of 33/36 is passed' do
			it 'should return 3/36' do
				oc_prob = 33/36.to_r
				expect(analyze.calculate_gc_dc_roll_probability(oc_prob)).to eq(3/36.to_r)
			end
		end
		context 'when a OC of 35/36 is passed' do
			it 'should return 1/36' do
				oc_prob = 35/36.to_r
				expect(analyze.calculate_gc_dc_roll_probability(oc_prob)).to eq(1/36.to_r)
			end
		end
		context 'when a OC of 36/36 is passed' do
			it 'should return 0/36' do
				oc_prob = 36/36.to_r
				expect(analyze.calculate_gc_dc_roll_probability(oc_prob)).to eq(0/36.to_r)
			end
		end
	end

	# calculate_gc_tt_roll_probability(wrestler_hash)
	describe '#calculate_gc_tt_roll_probability' do
		def wrestler_gc_hash(oc_values)
			gc_hash = { :GC02 => 'OC', :GC03 => 'OC', :GC04 => 'DC', :GC05 => 'OC', 
				:GC06 => 'DC', :GC07 => 'OC', :GC08 => 'OC', :GC09 => 'DC', :GC10 => 'OC', 
				:GC11 => 'OC', :GC12 => 'OC' }
			gc_hash.merge(oc_values)
		end
		context 'when a no values of \'OC/TT\' are passed' do
			it 'should return (0/36)' do
				wrestler_hash = wrestler_gc_hash({})
				expect(analyze.calculate_gc_tt_roll_probability(wrestler_hash)).to eq(0/36.to_r)
			end
		end
		context 'when a \':GC02 => \'OC/TT\'\' is passed' do
			it 'should return (1/36)' do
				wrestler_hash = wrestler_gc_hash({:GC02 => 'OC/TT'})
				expect(analyze.calculate_gc_tt_roll_probability(wrestler_hash)).to eq(1/36.to_r)
			end
		end
		context 'when a \':GC03 => \'OC/TT\'\' is passed' do
			it 'should return (2/36)' do
				wrestler_hash = wrestler_gc_hash({:GC03 => 'OC/TT'})
				expect(analyze.calculate_gc_tt_roll_probability(wrestler_hash)).to eq(2/36.to_r)
			end
		end
		context 'when a \':GC04 => \'OC/TT\'\' is passed' do
			it 'should return (3/36)' do
				wrestler_hash = wrestler_gc_hash({:GC04 => 'OC/TT'})
				expect(analyze.calculate_gc_tt_roll_probability(wrestler_hash)).to eq(3/36.to_r)
			end
		end
		context 'when a \':GC05 => \'OC/TT\'\' is passed' do
			it 'should return (4/36)' do
				wrestler_hash = wrestler_gc_hash({:GC05 => 'OC/TT'})
				expect(analyze.calculate_gc_tt_roll_probability(wrestler_hash)).to eq(4/36.to_r)
			end
		end
		context 'when a \':GC06 => \'OC/TT\'\' is passed' do
			it 'should return (5/36)' do
				wrestler_hash = wrestler_gc_hash({:GC06 => 'OC/TT'})
				expect(analyze.calculate_gc_tt_roll_probability(wrestler_hash)).to eq(5/36.to_r)
			end
		end
		context 'when a \':GC07 => \'OC/TT\'\' is passed' do
			it 'should return (6/36)' do
				wrestler_hash = wrestler_gc_hash({:GC07 => 'OC/TT'})
				expect(analyze.calculate_gc_tt_roll_probability(wrestler_hash)).to eq(6/36.to_r)
			end
		end
		context 'when a \':GC08 => \'OC/TT\'\' is passed' do
			it 'should return (5/36)' do
				wrestler_hash = wrestler_gc_hash({:GC08 => 'OC/TT'})
				expect(analyze.calculate_gc_tt_roll_probability(wrestler_hash)).to eq(5/36.to_r)
			end
		end
		context 'when a \':GC09 => \'OC/TT\'\' is passed' do
			it 'should return (4/36)' do
				wrestler_hash = wrestler_gc_hash({:GC09 => 'OC/TT'})
				expect(analyze.calculate_gc_tt_roll_probability(wrestler_hash)).to eq(4/36.to_r)
			end
		end
		context 'when a \':GC10 => \'OC/TT\'\' is passed' do
			it 'should return (3/36)' do
				wrestler_hash = wrestler_gc_hash({:GC10 => 'OC/TT'})
				expect(analyze.calculate_gc_tt_roll_probability(wrestler_hash)).to eq(3/36.to_r)
			end
		end
		context 'when a \':GC11 => \'OC/TT\'\' is passed' do
			it 'should return (2/36)' do
				wrestler_hash = wrestler_gc_hash({:GC11 => 'OC/TT'})
				expect(analyze.calculate_gc_tt_roll_probability(wrestler_hash)).to eq(2/36.to_r)
			end
		end
		context 'when a \':GC12 => \'OC/TT\'\' is passed' do
			it 'should return (1/36)' do
				wrestler_hash = wrestler_gc_hash({:GC12 => 'OC/TT'})
				expect(analyze.calculate_gc_tt_roll_probability(wrestler_hash)).to eq(1/36.to_r)
			end
		end
	end

	# calculate_reverse_roll_probability(wrestler_hash, gc_dc_roll_probability)
	describe '#calculate_reverse_roll_probability' do
		def wrestler_dc_hash(reverse_values)
			dc_hash = { :DC02 => 'B', :DC03 => 'A', :DC04 => 'B', :DC05 => 'A', 
				:DC06 => 'B', :DC07 => 'A', :DC08 => 'B', :DC09 => 'A', :DC10 => 'B', 
				:DC11 => 'A', :DC12 => 'B' }
			dc_hash.merge(reverse_values)
		end
		context 'when a \':GC02\' value of \'REVERSE\' and a DC roll probability of \'21/36.to_r\' is passed' do
			it 'should return (7/432)' do
				dc_hash = wrestler_dc_hash({:DC02 => 'REVERSE'})
				dc_roll_prob = 21/36.to_r
				expect(analyze.calculate_reverse_roll_probability(dc_hash, dc_roll_prob)).to eq(7/432.to_r)
			end
		end
		context 'when a \':GC03\' value of \'REVERSE\' and a DC roll probability of \'21/36.to_r\' is passed' do
			it 'should return (7/216)' do
				dc_hash = wrestler_dc_hash({:DC03 => 'REVERSE'})
				dc_roll_prob = 21/36.to_r
				expect(analyze.calculate_reverse_roll_probability(dc_hash, dc_roll_prob)).to eq(7/216.to_r)
			end
		end
		context 'when a \':GC04\' value of \'REVERSE\' and a DC roll probability of \'21/36.to_r\' is passed' do
			it 'should return (7/144)' do
				dc_hash = wrestler_dc_hash({:DC04 => 'REVERSE'})
				dc_roll_prob = 21/36.to_r
				expect(analyze.calculate_reverse_roll_probability(dc_hash, dc_roll_prob)).to eq(7/144.to_r)
			end
		end
		context 'when a \':GC05\' value of \'REVERSE\' and a DC roll probability of \'21/36.to_r\' is passed' do
			it 'should return (7/108)' do
				dc_hash = wrestler_dc_hash({:DC05 => 'REVERSE'})
				dc_roll_prob = 21/36.to_r
				expect(analyze.calculate_reverse_roll_probability(dc_hash, dc_roll_prob)).to eq(7/108.to_r)
			end
		end
		context 'when a \':GC06\' value of \'REVERSE\' and a DC roll probability of \'21/36.to_r\' is passed' do
			it 'should return (35/432)' do
				dc_hash = wrestler_dc_hash({:DC06 => 'REVERSE'})
				dc_roll_prob = 21/36.to_r
				expect(analyze.calculate_reverse_roll_probability(dc_hash, dc_roll_prob)).to eq(35/432.to_r)
			end
		end
		context 'when a \':GC07\' value of \'REVERSE\' and a DC roll probability of \'21/36.to_r\' is passed' do
			it 'should return (7/72)' do
				dc_hash = wrestler_dc_hash({:DC07 => 'REVERSE'})
				dc_roll_prob = 21/36.to_r
				expect(analyze.calculate_reverse_roll_probability(dc_hash, dc_roll_prob)).to eq(7/72.to_r)
			end
		end
		context 'when a \':GC08\' value of \'REVERSE\' and a DC roll probability of \'21/36.to_r\' is passed' do
			it 'should return (35/432)' do
				dc_hash = wrestler_dc_hash({:DC08 => 'REVERSE'})
				dc_roll_prob = 21/36.to_r
				expect(analyze.calculate_reverse_roll_probability(dc_hash, dc_roll_prob)).to eq(35/432.to_r)
			end
		end
		context 'when a \':GC09\' value of \'REVERSE\' and a DC roll probability of \'21/36.to_r\' is passed' do
			it 'should return (7/108)' do
				dc_hash = wrestler_dc_hash({:DC09 => 'REVERSE'})
				dc_roll_prob = 21/36.to_r
				expect(analyze.calculate_reverse_roll_probability(dc_hash, dc_roll_prob)).to eq(7/108.to_r)
			end
		end
		context 'when a \':GC10\' value of \'REVERSE\' and a DC roll probability of \'21/36.to_r\' is passed' do
			it 'should return (3/36)' do
				dc_hash = wrestler_dc_hash({:DC10 => 'REVERSE'})
				dc_roll_prob = 21/36.to_r
				expect(analyze.calculate_reverse_roll_probability(dc_hash, dc_roll_prob)).to eq(7/144.to_r)
			end
		end
		context 'when a \':GC11\' value of \'REVERSE\' and a DC roll probability of \'21/36.to_r\' is passed' do
			it 'should return (2/36)' do
				dc_hash = wrestler_dc_hash({:DC11 => 'REVERSE'})
				dc_roll_prob = 21/36.to_r
				expect(analyze.calculate_reverse_roll_probability(dc_hash, dc_roll_prob)).to eq(7/216.to_r)
			end
		end
		context 'when a \':GC12\' value of \'REVERSE\' and a DC roll probability of \'21/36.to_r\' is passed' do
			it 'should return (7/432)' do
				dc_hash = wrestler_dc_hash({:DC12 => 'REVERSE'})
				dc_roll_prob = 21/36.to_r
				expect(analyze.calculate_reverse_roll_probability(dc_hash, dc_roll_prob)).to eq(7/432.to_r)
			end
		end
		context 'when a \':GC02\' & \':GC06\' value of \'REVERSE\' and a DC roll probability of \'21/36.to_r\' is passed' do
			it 'should return (7/72)' do
				dc_hash = wrestler_dc_hash({:DC02 => 'REVERSE', :DC06 => 'REVERSE'})
				dc_roll_prob = 21/36.to_r
				expect(analyze.calculate_reverse_roll_probability(dc_hash, dc_roll_prob)).to eq(7/72.to_r)
			end
		end
		context 'when no values of \'REVERSE\' and a DC roll probability of \'21/36.to_r\' is passed' do
			it 'should return (7/72)' do
				dc_hash = wrestler_dc_hash({})
				dc_roll_prob = 21/36.to_r
				expect(analyze.calculate_reverse_roll_probability(dc_hash, dc_roll_prob)).to eq(0)
			end
		end
	end

	# TODO: Work on format of tests.
	# https://relishapp.com/rspec/rspec-expectations/v/3-8/docs/built-in-matchers/be-within-matcher
	# calculate_dc_points(k,v)
	describe '#calculate_dc_points' do
		context 'when a hash with a key of \':DC02\' and a value of \'A\' is passed' do
			dc_key = :DC02
			dc_value = 'A'
			it 'returns a value within 0.001 of 0.055' do
				expect(analyze.calculate_dc_points(dc_key, dc_value)).to be_within(0.001).of(0.055)
			end
		end
		context 'when a hash with a key of \':DC03\' and a value of \'A\' is passed' do
			dc_key = :DC03
			dc_value = 'A'
			it 'returns a value within 0.001 of 0.111' do
				expect(analyze.calculate_dc_points(dc_key, dc_value)).to be_within(0.001).of(0.111)
			end
		end
		context 'when a hash with a key of \':DC04\' and a value of \'A\' is passed' do
			dc_key = :DC04
			dc_value = 'A'
			it 'returns a value within 0.001 of 0.166' do
				expect(analyze.calculate_dc_points(dc_key, dc_value)).to be_within(0.001).of(0.166)
			end
		end
		context 'when a hash with a key of \':DC05\' and a value of \'A\' is passed' do
			dc_key = :DC05
			dc_value = 'A'
			it 'returns a value within 0.001 of 0.222' do
				expect(analyze.calculate_dc_points(dc_key, dc_value)).to be_within(0.001).of(0.222)
			end
		end
		context 'when a hash with a key of \':DC06\' and a value of \'A\' is passed' do
			dc_key = :DC06
			dc_value = 'A'
			it 'returns a value within 0.001 of 0.277' do
				expect(analyze.calculate_dc_points(dc_key, dc_value)).to be_within(0.001).of(0.277)
			end
		end
		context 'when a hash with a key of \':DC07\' and a value of \'A\' is passed' do
			dc_key = :DC07
			dc_value = 'A'
			it 'returns a value within 0.001 of 0.333' do
				expect(analyze.calculate_dc_points(dc_key, dc_value)).to be_within(0.001).of(0.333)
			end
		end
		context 'when a hash with a key of \':DC08\' and a value of \'A\' is passed' do
			dc_key = :DC08
			dc_value = 'A'
			it 'returns a value within 0.001 of 0.277' do
				expect(analyze.calculate_dc_points(dc_key, dc_value)).to be_within(0.001).of(0.277)
			end
		end
		context 'when a hash with a key of \':DC09\' and a value of \'A\' is passed' do
			dc_key = :DC09
			dc_value = 'A'
			it 'returns a value within 0.001 of 0.222' do
				expect(analyze.calculate_dc_points(dc_key, dc_value)).to be_within(0.001).of(0.222)
			end
		end
		context 'when a hash with a key of \':DC10\' and a value of \'A\' is passed' do
			dc_key = :DC10
			dc_value = 'A'
			it 'returns a value within 0.001 of 0.166' do
				expect(analyze.calculate_dc_points(dc_key, dc_value)).to be_within(0.001).of(0.166)
			end
		end
		context 'when a hash with a key of \':DC11\' and a value of \'A\' is passed' do
			dc_key = :DC11
			dc_value = 'A'
			it 'returns a value within 0.001 of 0.111' do
				expect(analyze.calculate_dc_points(dc_key, dc_value)).to be_within(0.001).of(0.111)
			end
		end
		context 'when a hash with a key of \':DC12\' and a value of \'A\' is passed' do
			dc_key = :DC12
			dc_value = 'A'
			it 'returns a value within 0.001 of 0.055' do
				expect(analyze.calculate_dc_points(dc_key, dc_value)).to be_within(0.001).of(0.055)
			end
		end
		context 'when a hash with a key of \':DC02\' and a value of \'B\' is passed' do
			dc_key = :DC02
			dc_value = 'B'
			it 'returns 0' do
				expect(analyze.calculate_dc_points(dc_key, dc_value)).to eq(0)
			end
		end
		context 'when a hash with a key of \':DC03\' and a value of \'B\' is passed' do
			dc_key = :DC03
			dc_value = 'B'
			it 'returns 0' do
				expect(analyze.calculate_dc_points(dc_key, dc_value)).to eq(0)
			end
		end
		context 'when a hash with a key of \':DC04\' and a value of \'B\' is passed' do
			dc_key = :DC04
			dc_value = 'B'
			it 'returns 0' do
				expect(analyze.calculate_dc_points(dc_key, dc_value)).to eq(0)
			end
		end
		context 'when a hash with a key of \':DC05\' and a value of \'B\' is passed' do
			dc_key = :DC05
			dc_value = 'B'
			it 'returns 0' do
				expect(analyze.calculate_dc_points(dc_key, dc_value)).to eq(0)
			end
		end
		context 'when a hash with a key of \':DC06\' and a value of \'B\' is passed' do
			dc_key = :DC06
			dc_value = 'B'
			it 'returns 0' do
				expect(analyze.calculate_dc_points(dc_key, dc_value)).to eq(0)
			end
		end
		context 'when a hash with a key of \':DC07\' and a value of \'B\' is passed' do
			dc_key = :DC07
			dc_value = 'B'
			it 'returns 0' do
				expect(analyze.calculate_dc_points(dc_key, dc_value)).to eq(0)
			end
		end
		context 'when a hash with a key of \':DC08\' and a value of \'B\' is passed' do
			dc_key = :DC08
			dc_value = 'B'
			it 'returns 0' do
				expect(analyze.calculate_dc_points(dc_key, dc_value)).to eq(0)
			end
		end
		context 'when a hash with a key of \':DC09\' and a value of \'B\' is passed' do
			dc_key = :DC09
			dc_value = 'B'
			it 'returns 0' do
				expect(analyze.calculate_dc_points(dc_key, dc_value)).to eq(0)
			end
		end
		context 'when a hash with a key of \':DC10\' and a value of \'B\' is passed' do
			dc_key = :DC10
			dc_value = 'B'
			it 'returns 0' do
				expect(analyze.calculate_dc_points(dc_key, dc_value)).to eq(0)
			end
		end
		context 'when a hash with a key of \':DC11\' and a value of \'B\' is passed' do
			dc_key = :DC11
			dc_value = 'B'
			it 'returns 0' do
				expect(analyze.calculate_dc_points(dc_key, dc_value)).to eq(0)
			end
		end
		context 'when a hash with a key of \':DC12\' and a value of \'B\' is passed' do
			dc_key = :DC12
			dc_value = 'B'
			it 'returns 0' do
				expect(analyze.calculate_dc_points(dc_key, dc_value)).to eq(0)
			end
		end
		context 'when a hash with a key of \':DC02\' and a value of \'C\' is passed' do
			dc_key = :DC02
			dc_value = 'C'
			it 'returns a value within 0.001 of 0.111' do
				expect(analyze.calculate_dc_points(dc_key, dc_value)).to be_within(0.001).of(0.111)
			end
		end
		context 'when a hash with a key of \':DC03\' and a value of \'C\' is passed' do
			dc_key = :DC03
			dc_value = 'C'
			it 'returns a value within 0.001 of 0.222' do
				expect(analyze.calculate_dc_points(dc_key, dc_value)).to be_within(0.001).of(0.222)
			end
		end
		context 'when a hash with a key of \':DC04\' and a value of \'C\' is passed' do
			dc_key = :DC04
			dc_value = 'C'
			it 'returns a value within 0.001 of 0.333' do
				expect(analyze.calculate_dc_points(dc_key, dc_value)).to be_within(0.001).of(0.333)
			end
		end
		context 'when a hash with a key of \':DC05\' and a value of \'C\' is passed' do
			dc_key = :DC05
			dc_value = 'C'
			it 'returns a value within 0.001 of 0.444' do
				expect(analyze.calculate_dc_points(dc_key, dc_value)).to be_within(0.001).of(0.444)
			end
		end
		context 'when a hash with a key of \':DC06\' and a value of \'C\' is passed' do
			dc_key = :DC06
			dc_value = 'C'
			it 'returns a value within 0.001 of 0.555' do
				expect(analyze.calculate_dc_points(dc_key, dc_value)).to be_within(0.001).of(0.555)
			end
		end
		context 'when a hash with a key of \':DC07\' and a value of \'C\' is passed' do
			dc_key = :DC07
			dc_value = 'C'
			it 'returns a value within 0.001 of 0.666' do
				expect(analyze.calculate_dc_points(dc_key, dc_value)).to be_within(0.001).of(0.666)
			end
		end
		context 'when a hash with a key of \':DC08\' and a value of \'C\' is passed' do
			dc_key = :DC08
			dc_value = 'C'
			it 'returns a value within 0.001 of 0.555' do
				expect(analyze.calculate_dc_points(dc_key, dc_value)).to be_within(0.001).of(0.555)
			end
		end
		context 'when a hash with a key of \':DC09\' and a value of \'C\' is passed' do
			dc_key = :DC09
			dc_value = 'C'
			it 'returns a value within 0.001 of 0.444' do
				expect(analyze.calculate_dc_points(dc_key, dc_value)).to be_within(0.001).of(0.444)
			end
		end
		context 'when a hash with a key of \':DC10\' and a value of \'C\' is passed' do
			dc_key = :DC10
			dc_value = 'C'
			it 'returns a value within 0.001 of 0.333' do
				expect(analyze.calculate_dc_points(dc_key, dc_value)).to be_within(0.001).of(0.333)
			end
		end
		context 'when a hash with a key of \':DC11\' and a value of \'C\' is passed' do
			dc_key = :DC11
			dc_value = 'C'
			it 'returns a value within 0.001 of 0.222' do
				expect(analyze.calculate_dc_points(dc_key, dc_value)).to be_within(0.001).of(0.222)
			end
		end
		context 'when a hash with a key of \':DC12\' and a value of \'C\' is passed' do
			dc_key = :DC12
			dc_value = 'C'
			it 'returns a value within 0.001 of 0.111' do
				expect(analyze.calculate_dc_points(dc_key, dc_value)).to be_within(0.001).of(0.111)
			end
		end
		context 'when a hash with a key of \':DC02\' and a value of \'C\' is passed' do
			dc_key = :DC02
			dc_value = 'REVERSE'
			it 'returns 0' do
				expect(analyze.calculate_dc_points(dc_key, dc_value)).to eq(0)
			end
		end
		context 'when a hash with a key of \':DC03\' and a value of \'C\' is passed' do
			dc_key = :DC03
			dc_value = 'REVERSE'
			it 'returns 0' do
				expect(analyze.calculate_dc_points(dc_key, dc_value)).to eq(0)
			end
		end
		context 'when a hash with a key of \':DC04\' and a value of \'C\' is passed' do
			dc_key = :DC04
			dc_value = 'REVERSE'
			it 'returns 0' do
				expect(analyze.calculate_dc_points(dc_key, dc_value)).to eq(0)
			end
		end
		context 'when a hash with a key of \':DC05\' and a value of \'C\' is passed' do
			dc_key = :DC05
			dc_value = 'REVERSE'
			it 'returns 0' do
				expect(analyze.calculate_dc_points(dc_key, dc_value)).to eq(0)
			end
		end
		context 'when a hash with a key of \':DC06\' and a value of \'C\' is passed' do
			dc_key = :DC06
			dc_value = 'REVERSE'
			it 'returns 0' do
				expect(analyze.calculate_dc_points(dc_key, dc_value)).to eq(0)
			end
		end
		context 'when a hash with a key of \':DC07\' and a value of \'C\' is passed' do
			dc_key = :DC07
			dc_value = 'REVERSE'
			it 'returns 0' do
				expect(analyze.calculate_dc_points(dc_key, dc_value)).to eq(0)
			end
		end
		context 'when a hash with a key of \':DC08\' and a value of \'C\' is passed' do
			dc_key = :DC08
			dc_value = 'REVERSE'
			it 'returns 0' do
				expect(analyze.calculate_dc_points(dc_key, dc_value)).to eq(0)
			end
		end
		context 'when a hash with a key of \':DC09\' and a value of \'C\' is passed' do
			dc_key = :DC09
			dc_value = 'REVERSE'
			it 'returns 0' do
				expect(analyze.calculate_dc_points(dc_key, dc_value)).to eq(0)
			end
		end
		context 'when a hash with a key of \':DC10\' and a value of \'C\' is passed' do
			dc_key = :DC10
			dc_value = 'REVERSE'
			it 'returns 0' do
				expect(analyze.calculate_dc_points(dc_key, dc_value)).to eq(0)
			end
		end
		context 'when a hash with a key of \':DC11\' and a value of \'C\' is passed' do
			dc_key = :DC11
			dc_value = 'REVERSE'
			it 'returns 0' do
				expect(analyze.calculate_dc_points(dc_key, dc_value)).to eq(0)
			end
		end
		context 'when a hash with a key of \':DC12\' and a value of \'C\' is passed' do
			dc_key = :DC12
			dc_value = 'REVERSE'
			it 'returns 0' do
				expect(analyze.calculate_dc_points(dc_key, dc_value)).to eq(0)
			end
		end
	end

	describe '#calculate_oc_and_ropes_points' do
		context 'when the Zak Knight OC values are passed' do
			wrestler = {:OC02=>"Superkick 10",
			 :OC03=>"Zodiac Sleeper 9 *",
			 :OC04=>"Reverse Neckbreaker 8 (XX)",
			 :OC05=>"Rainmaker (S)",
			 :OC06=>"Zak Smack 7",
			 :OC07=>"Bodyslam 8",
			 :OC08=>"Forearm Smash 7",
			 :OC09=>"Stomp 6",
			 :OC10=>"European Uppercut 7",
			 :OC11=>"Spinning Side Slam 8",
			 :OC12=>"ROPES"}
			it 'returns a value within 0.001 of 6.416' do
				expect(analyze.calculate_oc_and_ropes_points(wrestler)).to be_within(0.001).of(6.416)
			end
		end
	end

	# calculate_oc_points_per_roll_subtotal(points, oc_prob)
	describe '#calculate_oc_points_per_roll_subtotal' do
		context 'when a probability of \'21/36.to_r\' and a value of \'8.0\' is passed' do
			it 'returns a value within 0.001 of 3.921' do
				expect(analyze.calculate_oc_points_per_roll_subtotal(8.0, 21/36.to_r)).to be_within(0.001).of(4.666)
			end
		end
		context 'when a probability of \'11/18.to_r\' and a value of \'6.416666666666667\' is passed' do
			it 'returns a value within 0.001 of 3.921' do
				expect(analyze.calculate_oc_points_per_roll_subtotal(6.416666666666667, 11/18.to_r)).to be_within(0.001).of(3.921)
			end
		end
	end

	# calculate_ropes_points_per_roll_subtotal(points, oc_prob, ropes_prob)
	# points: 3.833333333333333, oc_prob: (11/18), ropes_prob: (1/36)
	describe '#calculate_ropes_points_per_roll_subtotal' do
		context 'when a points value of 3.833333333333333, a oc_prob of (11/18) and a ropes_prob of (1/36) is passed' do
			it 'returns a value within 0.001 of 0.065' do
				expect(analyze.calculate_ropes_points_per_roll_subtotal(3.833333333333333, 11/18.to_r, 1/36.to_r)).to be_within(0.001).of(0.065)
			end
		end
		context 'when a points value of 4, a oc_prob of (16/36) and a ropes_prob of (1/36) is passed' do
			it 'returns a value within 0.001 of 0.049' do
				expect(analyze.calculate_ropes_points_per_roll_subtotal(4.0, 16/36.to_r, 1/36.to_r)).to be_within(0.001).of(0.049)
			end
		end
	end

	# calculate_specialty_dq_pa_subm_xx_probability(wrestler, move)
	describe '#calculate_specialty_dq_pa_subm_xx_probability' do
		context 'when a wrestler object includes { :OC02=>"Superkick 10 P/A" } and the move attribute is \'P/A\'' do
			it 'returns a value of {:OC=>(1/36), :R=>0}' do
				w = { :OC02=>"Superkick 10 P/A" }
				expect(analyze.calculate_specialty_dq_pa_subm_xx_probability(w, 'P/A')).to eq({:OC=>(1/36.to_r), :R=>0})
			end
		end
		context 'when a wrestler object includes { :OC02=>"Superkick 10 P/A", :OC07=>"Flying Body Press 10P/A" } and the move attribute is \'P/A\'' do
			it 'returns a value of {:OC=>(7/36), :R=>0}' do
				w = { :OC02=>"Superkick 10 P/A", :OC07=>"Flying Body Press 10P/A" }
				expect(analyze.calculate_specialty_dq_pa_subm_xx_probability(w, 'P/A')).to eq({:OC=>(7/36.to_r), :R=>0})
			end
		end
		context 'when a wrestler object includes { :OC02=>"Superkick 10 P/A", :R07=>"Flying Body Press 10P/A" } and the move attribute is \'P/A\'' do
			it 'returns a value of {:OC=>(1/36), :R=>6/36}' do
				w = { :OC02=>"Superkick 10 P/A", :R07=>"Flying Body Press 10P/A" }
				expect(analyze.calculate_specialty_dq_pa_subm_xx_probability(w, 'P/A')).to eq({:OC=>(1/36.to_r), :R=>6/36.to_r})
			end
		end
		context 'when a wrestler object includes { :OC03=>"Zodiac Sleeper 9 *" } and the move attribute is \'*\'' do
			it 'returns a value of {:OC=>(2/36), :R=>0}' do
				w = { :OC03=>"Zodiac Sleeper 9 *" }
				expect(analyze.calculate_specialty_dq_pa_subm_xx_probability(w, '*')).to eq({:OC=>(2/36.to_r), :R=>0})
			end
		end
		context 'when a wrestler object includes { :OC03=>"Zodiac Sleeper 9 *", :OC12=>"Sleeper Hold 6*" } and the move attribute is \'*\'' do
			it 'returns a value of {:OC=>(3/36), :R=>0}' do
				w = { :OC03=>"Zodiac Sleeper 9 *", :OC12=>"Sleeper Hold 6*" }
				expect(analyze.calculate_specialty_dq_pa_subm_xx_probability(w, '*')).to eq({:OC=>(3/36.to_r), :R=>0})
			end
		end
		context 'when a wrestler object includes { :OC03=>"Zodiac Sleeper 9 *", :R12=>"Dropkick 7 P/A" } and the move attribute is \'P/A\'' do
			it 'returns a value of {:OC=>0, :R=>(1/36) }' do
				w = { :OC03=>"Zodiac Sleeper 9 *", :R12=>"Dropkick 7 P/A" }
				expect(analyze.calculate_specialty_dq_pa_subm_xx_probability(w, 'P/A')).to eq({:OC=>0, :R=>1/36.to_r})
			end
		end
		context 'when a wrestler object includes { :OC03=>"Zodiac Sleeper 9 *", :R12=>"Dropkick 7 P/A" } and the move attribute is \'*\'' do
			it 'returns a value of {:OC=>0, :R=>(1/36) }' do
				w = { :OC03=>"Zodiac Sleeper 9 *", :R12=>"Dropkick 7 P/A" }
				expect(analyze.calculate_specialty_dq_pa_subm_xx_probability(w, '*')).to eq({:OC=>2/36.to_r, :R=>0})
			end
		end
		context 'when a wrestler object includes { :OC02=>"ROPES" } and the move attribute is \'ROPES\'' do
			it 'returns a value of {:OC=>1/36, :R=>0 }' do
				w = { :OC02=>"ROPES" }
				expect(analyze.calculate_specialty_dq_pa_subm_xx_probability(w, 'ROPES')).to eq({:OC=>1/36.to_r, :R=>0 })
			end
		end
		context 'when a wrestler object includes { :OC04=>"DQ", :R05=>"DQ" } and the move attribute is \'DQ\'' do
			it 'returns a value of {:OC=>3/36, :R=>4/36 }' do
				w = { :OC04=>"DQ", :R05=>"DQ" }
				expect(analyze.calculate_specialty_dq_pa_subm_xx_probability(w, 'DQ')).to eq({:OC=>3/36.to_r, :R=>4/36.to_r })
			end
		end
		context 'when a wrestler object includes { :OC04=>"DQ", :OC08=>"DQ", :R05=>"DQ", :R11=>"DQ" } and the move attribute is \'DQ\'' do
			it 'returns a value of {:OC=>8/36, :R=>6/36 }' do
				w = { :OC04=>"DQ", :OC08=>"DQ", :R05=>"DQ", :R11=>"DQ" }
				expect(analyze.calculate_specialty_dq_pa_subm_xx_probability(w, 'DQ')).to eq({:OC=>8/36.to_r, :R=>6/36.to_r })
			end
		end
		context 'when a wrestler object includes { :OC07=>"XX" } and the move attribute is \'XX\'' do
			it 'returns a value of {:OC=>6/36.to_r, :R=>0 }' do
				w = { :OC07=>"XX" }
				expect(analyze.calculate_specialty_dq_pa_subm_xx_probability(w, 'XX')).to eq({:OC=>6/36.to_r, :R=>0 })
			end
		end
		context 'when a wrestler object includes { :R05=>"XX" } and the move attribute is \'XX\'' do
			it 'returns a value of {:OC=>0, :R=>4/36 }' do
				w = { :R05=>"XX" }
				expect(analyze.calculate_specialty_dq_pa_subm_xx_probability(w, 'XX')).to eq({:OC=>0, :R=>4/36.to_r })
			end
		end
		context 'when a wrestler object includes { :OC07=>"XX", :OC08=>"XX" } and the move attribute is \'XX\'' do
			it 'returns a value of {:OC=>11/36, :R=>0 }' do
				w = { :OC07=>"XX", :OC08=>"XX" }
				expect(analyze.calculate_specialty_dq_pa_subm_xx_probability(w, 'XX')).to eq({:OC=>11/36.to_r, :R=>0 })
			end
		end
		context 'when a wrestler object includes { :OC05=>"(S)" } and the move attribute is \'(S)\'' do
			it 'returns a value of {:OC=>4/36, :R=>0 }' do
				w = { :OC05=>"(S)" }
				expect(analyze.calculate_specialty_dq_pa_subm_xx_probability(w, '(S)')).to eq({:OC=>4/36.to_r, :R=>0 })
			end
		end
		context 'when a wrestler object includes { :R05=>"(S)" } and the move attribute is \'(S)\'' do
			it 'returns a value of {:OC=>0, :R=>4/36 }' do
				w = { :R05=>"(S)" }
				expect(analyze.calculate_specialty_dq_pa_subm_xx_probability(w, '(S)')).to eq({:OC=>0, :R=>4/36.to_r })
			end
		end
		context 'when a wrestler object includes { :R05=>"(S)", :R11=>"(S)" } and the move attribute is \'(S)\'' do
			it 'returns a value of {:OC=>0, :R=>6/36 }' do
				w = { :R05=>"(S)", :R11=>"(S)" }
				expect(analyze.calculate_specialty_dq_pa_subm_xx_probability(w, '(S)')).to eq({:OC=>0, :R=>6/36.to_r })
			end
		end
	end

	# calculate_specialty_points_and_attributes(wrestler)
	describe '#calculate_specialty_points_and_attributes' do
		context 'when a wrestler object that includes { :S1=>"9", :S2=>"10", :S3=>"11 P/A", :S4=>"8 P/A", :S5=>"12", :S6=>"10" } is passed.' do
			h = {  :S1=>"9", :S2=>"10", :S3=>"11 P/A", :S4=>"8 P/A", :S5=>"12", :S6=>"10" }
			let(:hash_result) { analyze.calculate_specialty_points_and_attributes(h) }

			it 'returns a hash with a :dq_probability value of 0' do
				expect(hash_result[:dq_probability]).to eq(0)
			end
			it 'returns a hash with a :pa_probability value within 0.001 of 0.333' do
				expect(hash_result[:pa_probability]).to be_within(0.001).of(0.333)
			end
		end
	end
	


	# TODO: Create test that deals with DQs in Specialty moves.
	# TODO: Run rspec -w to print out warnings and fix issues.
	# TODO: Create and/or tests like (x should be either OC or DC)
	

end