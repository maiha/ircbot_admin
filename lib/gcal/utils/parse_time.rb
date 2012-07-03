class Gcal::Utils::ParseTime
  def self.parse(text)
  end

  def intialize(date, text)
    @date = date
    @text = text
  end

  def start
    self.class.parse(@text)
  end
end
