require 'open-uri'

class Gcal::Gateway::Reminder
  include Ccp::Commands::Core

  def execute
    events = data[:events]
    source = "script/gcal/ics"

    Event.transaction {
      Event.where(:source=>source).delete_all
      events.each do |hash|
        # attr_accessible :st, :en, :title, :desc, :source, :where, :allday, :alert_at
        attrs = hash.merge("source" => source)
        attrs["alert_at"] = attrs["st"] - 30*60
        Event.create!(attrs)
      end      
    }
  end
end
