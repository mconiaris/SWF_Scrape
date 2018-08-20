require 'pdf-reader'
require 'pry'


RSpec.describe Reader do
	it 'turns a PDF into text' do
		reader = PDF::Reader.new("files/Zak Knight.pdf")
		binding.pry
		puts reader
	end
end