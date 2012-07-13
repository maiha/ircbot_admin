require 'open-uri'

class Gcal::Gateway::DeleteAlerted
  include Ccp::Commands::Core

  def execute
    return unless data.set?(:delete_alerted)
    Event.where(:alerted=>true).delete_all
  end
end
