require 'open-uri'

class Gcal::Gateway::DeletePast
  include Ccp::Commands::Core

  def execute
    return unless data.set?(:delete_past)
    Event.where("st < ?", Time.now).delete_all
  end
end
