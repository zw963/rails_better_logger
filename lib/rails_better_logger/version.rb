#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

module $module
  VERSION = [0, 0, 1]

  class << VERSION
    def to_s
      join(?.)
    end
  end
end
