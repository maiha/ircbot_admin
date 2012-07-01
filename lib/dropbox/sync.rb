# -*- coding: utf-8 -*-

require 'logger'

module Dropbox
  class Sync
    def initialize(src, dst)
      @src    = src
      @dst    = dst
      @logger = Rails.logger
    end

    def status
      `dropbox status`.to_s.strip
    end

    def execute
      case status
      when 'Idle'
        log   = rsync
        files = parse(log)
        notify(files)
      when /.*/
        not_idle_error($&)
      end
    end

    def rsync
      Dir.chdir(@dst) {
        Open3.popen3("rsync", "-av", "--delete", @src, ".") {|i,o,e|
          buf = o.read{}
          @logger.debug "rsync: got %d bytes stdout" % buf.size
          return buf
        }
      }
    end

    def parse(log)
      dir = Pathname(@src).basename.to_s
      log.split(/\n/).grep(/^#{dir}\/.*[^\/]$/)
    end

    def notify(files)
      files.empty? and return false
      report = build_report(files).truncate(120)
      attrs = {
        :st       => Time.now,
        :en       => Time.now + 1.hour,
        :title    => "dropbox updated",
        :desc     => report,
        :alert_at => Time.now,
      }
      Event.create!(attrs)
      @logger.info "notify: #{report}"
    end

    def build_report(files)
      "[Dropbox] %dファイル(%s)" % [files.size, files.join(",")]
    end

    def not_idle_error(status)
      @logger.debug "[SKIP] not idle: #{status}"
    end
  end
end
