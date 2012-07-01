== Dropbox Sync

When the dropbox path is "~/Dropbox/wota", give it to sync.rb.

  ./script/dropbox/sync.rb ~/Dropbox/wota

This checks dropbox status first.
And when it is 'Idle', report added files to "db:events".

