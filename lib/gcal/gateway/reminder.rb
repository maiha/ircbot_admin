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
        st = hash["st"]
        attrs = hash.merge("source" => source)
        attrs["alert_at"] = st - 30*60
        attrs["desc"]     = "%s %s" % [pretty_time(st), hash["title"]]
        Event.create!(attrs)
      end      
    }
  end

  private
    def pretty_time(t)
      text = t.strftime("%Y-%m-%d %H:%M:%S")
      text.gsub!(/:00$/,'')     # strip sec
      text.gsub!(/00:00$/,'')   # strip hour:min
      return text.strip
    end
end
