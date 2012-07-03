class Event < ActiveRecord::Base
  attr_accessible :st, :en, :title, :desc, :source, :where, :allday, :alert_at
end
