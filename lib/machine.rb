require 'sax-machine'
require 'pry'

# Class for parsing an atom entry out of a feedburner atom feed
# class HistoryParser
#   include SAXMachine
#    value :name
# end

class DestinationParser
  include SAXMachine
  attribute :atlas_id
  element :overview
  elements :history, as: :history
end

# Class for parsing Atom feeds
class DestinationListParser
  include SAXMachine
  elements :destination, as: :destinatons, lazy: true, class: DestinationParser
end

xml_text = File.open('destinations.xml')
# you can then parse like this
feed = DestinationListParser.parse(xml_text)
binding.pry
# then you're ready to rock
# feed.title # => whatever the title of the blog is
# feed.url # => the main url of the blog
# feed.feed_url # => goes to the feedburner feed

feed.entries.first.title # => title of the first entry
feed.entries.first.author # => the author of the first entry
feed.entries.first.url # => the permalink on the blog for this entry
# etc ...

# you can also use the elements method without specifying a class like so
class SomeServiceResponse
  elements :message, :as => :messages
end

response = SomeServiceResponse.parse("<response><message>hi</message><message>world</message></response>")
response.messages.first # => "hi"
response.messages.last  # => "world"ropstream/sax-machine
