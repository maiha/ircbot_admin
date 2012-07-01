class Event < ActiveRecord::Base
  attr_accessible :st, :en, :title, :desc, :alert_at
end
