module EventsHelper
  def event_st_column(record)
    record.st.strftime("%Y-%m-%d %H:%M:%S") rescue '-'
  end
end
