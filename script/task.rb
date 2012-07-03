#!/usr/bin/env ruby1.8
# -*- coding: utf-8 -*-

unless defined? Rails
  require File.expand_path('../../config/environment',  __FILE__)
end

module Script
  class Task
    def self.[](cmd)
      new(cmd)
    end

    def initialize(cmd)
      @cmd = cmd
    end

    def execute(args)
      @cmd.must.duck("#execute") or halt("command not found: #{@cmd.class}")

      options = build_options!(args)

      Dir.chdir(Rails.root) {
        @cmd.execute(options)
      }

    rescue Typed::NotDefined => e
      halt "ConfigError: #{e}"
    end

    def build_options!(args)
      options = {}

      if args.delete("-s")
        options[:fixture_save] = proc{|c| !c.is_a?(Ccp::Commands::Composite)}
        options[:fixture_kvs]  = :dir
        options[:fixture_ext]  = :json
      end

      file = args.pop
      if file
        Pathname(file).exist? or halt("config not found: #{file}")
        options[:config_file] = file
      end

      return options
    end

    private
      def halt(msg)
        $stderr.puts msg
        exit(1)
      end
  end
end
