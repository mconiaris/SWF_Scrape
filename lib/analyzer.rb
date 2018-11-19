class Analyzer

	attr_accessor :statistics

	def initialize
		@statistics = Hash.new
	end

	def analyze(wrestler)
		wrestler.values.each {
			|key, value| k = key.to_s
			
				if k[0..1] == 'GC'
					puts "#{key}: #{value}"
				elsif k[0..1] == 'DC'
					puts "#{key}: #{value}"
				elsif k[0] == 'S'
					puts "#{key}: #{value}"
				elsif k[0..2] == 'Sub'
					puts "#{key}: #{value}"
				elsif k[0..2] == 'Tag'
					puts "#{key}: #{value}"
				elsif k[0..2] == 'Pri'
					puts "#{key}: #{value}"
				elsif k[0..1] == 'OC'
					puts "#{key}: #{value}"
				elsif k[0] == 'R'
					puts "#{key}: #{value}"
				end
		}
		binding.pry
	end

end