class Gcal::Calculate::Format
  include Ccp::Commands::Core

  def execute
    events = data[:events]
    format = data[:format]

    events.each do |hash|
      hash["desc"] = format % hash["desc"]
    end

    data[:events] = events
  end
end
