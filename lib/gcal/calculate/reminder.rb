class Gcal::Calculate::Reminder
  include Ccp::Commands::Core

  def execute
    events = data[:events]
    source = data[:source]

    events.each do |hash|
      # attr_accessible :st, :en, :title, :desc, :source, :where, :allday, :alert_at
      st = hash["st"]
      hash["source"]   = source
      hash["alert_at"] = st - 30*60
      hash["desc"]     = "%s %s" % [pretty_time(st), hash["title"]]
    end

    data[:events] = events
  end

  private
    def pretty_time(t)
      text = t.strftime("%Y-%m-%d %H:%M:%S")
      text.gsub!(/:00$/,'')     # strip sec
      text.gsub!(/00:00$/,'')   # strip hour:min
      return text.strip
    end
end
