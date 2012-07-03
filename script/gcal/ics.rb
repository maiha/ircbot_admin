#!/usr/bin/env ruby1.8
# -*- coding: utf-8 -*-

load File.dirname(__FILE__) + "/../task.rb"

Script::Task[Gcal::Main::Ics].execute(ARGV)
