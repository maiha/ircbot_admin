class Gcal::Calculate::Events
  include Ccp::Commands::Core

  def execute
    @events = []

    data[:icss].each do |ics|
      create_event(ics)
    end

    data[:events] = @events
  end

  def create_event(ics)
    cal = Icalendar.parse(ics, true)

    cal.events.each do |event|
      st = calculate_st(event)
      now < st or next

      @events << {
        "st"    => st,
        "en"    => event.end,
        "title" => event.summary,
        "where" => event.location,
        "desc"  => event.description,
      }
    end
  end

  def now
    @now ||= data.time(:now)
  end

  def calculate_st(event)
    date = event.start
    time = Time.mktime(date.year, date.month, date.day)
    return NightTime::Jst.parse(event.description, time)
  end
end
