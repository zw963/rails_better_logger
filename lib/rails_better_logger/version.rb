#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

module RailsBetterLogger
  VERSION = [0, 2, 2]

  class << VERSION
    def to_s
      join(?.)
    end
  end
end
