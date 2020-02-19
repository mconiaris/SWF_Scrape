require 'henkei'

class PagesScraper

	data = File.read 'sample.pages'
	text = Henkei.read :text, data
	metadata = Henkei.read :metadata, data
	mimetype = Henkei.read :mimetype, data

end