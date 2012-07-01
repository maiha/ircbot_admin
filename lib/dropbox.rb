module Dropbox
  def self.sync(src, dst)
    Sync.new(src, dst).execute
  end
end
