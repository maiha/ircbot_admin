class Gcal::Common::Variables
  include Ccp::Commands::Core

  def execute
    declare_variables
    default_variables
  end

  def declare_variables
    data[:now]    = Fixnum
    data[:feeds]  = [String]
    data[:icss]   = [String]
    data[:events] = [{String=>Object}]
  end

  def default_variables
    data.default[:now]    = Time.now.to_i
    data.default[:source] = "script/gcal/ics"
  end
end
