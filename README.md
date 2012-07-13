== Dropbox Sync

When the dropbox path is "~/Dropbox/wota", give it to sync.rb.

  ./script/dropbox/sync.rb ~/Dropbox/wota

This checks dropbox status first.
And when it is 'Idle', report added files to "db:events".


== Gcal

Copy config/samples/gcal.yml into config/gcal.yml, setup your configs.

  ./script/gcal/ics.rb config/gcal.yml


== Test

  rake db:test:prepare
  rake spec
    # or, bundle exec rspec -c spec

