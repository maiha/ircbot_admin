#!/usr/bin/env ruby1.8
# This command will automatically be run when you run "rails" with Rails 3 gems installed from the root of your application.

require 'pathname'

APP_PATH = File.expand_path('../../../config/application',  __FILE__)
require File.expand_path('../../../config/boot',  __FILE__)
ROOT = (Pathname(__FILE__) + '../../..').cleanpath

src  = ARGV.shift
dst  = ROOT + "dropbox"

if src.nil? or ARGV.size != 0
  $stdout.puts "no srcs given"; exit(-1)
end


src = Pathname(src).realpath.cleanpath
dst = Pathname(dst).realpath.cleanpath

cmd = "Dropbox.sync('%s','%s')" % [src, dst]
ARGV.replace([cmd])

require "rails/commands/runner"
