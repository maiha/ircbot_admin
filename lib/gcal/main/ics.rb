class Gcal::Main::Ics < Ccp::Invokers::Base
  command Gcal::Common::Variables
  command Gcal::Gateway::ConfigFile
  command Gcal::Gateway::LoadIcs
  command Gcal::Calculate::Events
  command Gcal::Calculate::Reminder
  command Gcal::Gateway::DeleteAlerted
  command Gcal::Gateway::DeletePast
  command Gcal::Gateway::Reminder
end
