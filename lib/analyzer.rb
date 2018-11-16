class Analyzer

	attr_accessor :statistics

	def initialize
		@statistics = Hash.new
	end

	def analyze(wrestler)
		wrestler.values.each {
			|key, value| puts "#{key}: #{value}"
		binding.pry
		}
	end

end