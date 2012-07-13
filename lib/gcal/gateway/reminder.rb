require 'open-uri'

class Gcal::Gateway::Reminder
  include Ccp::Commands::Core

  def execute
    events = data[:events]
    source = data[:source]

    Event.transaction {
      Event.where(:source=>source).delete_all
      events.each do |hash|
        Event.create!(hash)
      end      
    }
  end
end
