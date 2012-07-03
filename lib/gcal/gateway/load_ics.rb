require 'open-uri'

class Gcal::Gateway::LoadIcs
  include Ccp::Commands::Core

  def execute
    feeds = data[:feeds]
    icss  = feeds.map{|feed| load(feed)}
    data[:icss] = icss
  end

  def load(feed)
    open(feed).read{}
  end
end
