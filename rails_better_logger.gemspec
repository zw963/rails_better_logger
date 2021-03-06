#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require File.expand_path('../lib/rails_better_logger/version', __FILE__)

Gem::Specification.new do |s|
  s.name                        = 'rails_better_logger'
  s.version                     = RailsBetterLogger::VERSION.to_s
  s.date                        = Time.now.strftime('%F')
  s.required_ruby_version       = '>= 1.9.1'
  s.authors                     = ['Billy.Zheng(zw963)']
  s.email                       = ['zw963@163.com']
  s.summary                     = "Just is the canonical rails logger, you don't miss anything, just better!"
  s.description                 = ''
  s.homepage                    = 'http://github.com/zw963/rails_better_logger'
  s.license                     = 'MIT'
  s.require_paths               = ['lib']
  s.files                       = `git ls-files bin lib *.md LICENSE`.split("\n")
  s.files                       -= Dir['images/*.png']
  s.executables                 = `git ls-files -- bin/*`.split("\n").map {|f| File.basename(f) }

  s.add_runtime_dependency 'activesupport', '~> 4.0'
  s.add_development_dependency 'ritual', '~> 0.4'
end
