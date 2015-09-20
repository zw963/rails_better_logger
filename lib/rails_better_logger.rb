#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'rails_better_logger/version'
require 'active_support/log_subscriber'
require 'active_support/lazy_load_hooks'

ActiveSupport.on_load(:after_initialize) do |_app|
  module ActionView
    class LogSubscriber < ActiveSupport::LogSubscriber
      def info(progname=nil, &block)
        log = block_given? ? block.call : progname

        better_log = content
                     .sub(/([0-9]{3,})(.[0-9])?ms/, '[0m[31m\1\2ms[0m')
                     .sub(/[\w:]+Error/, '[0m[41m\1\2ms[0m')

        if block_given?
          super(progname) { better_log }
        else
          super(better_log)
        end
      end
    end
  end

  module ActiveSupport
    class Logger
      def info(progname=nil, &block)
        http_verb = Regexp.union(%w[GET POST PUT PATCH DELETE])
        log = block_given? ? block.call : progname

        better_log = content
                     .sub(/(#{http_verb} ".+")/, '[0m[32m\1[0m')
                     .sub(/[\w:]+Error/, '[0m[41m\1\2ms[0m')

        if block_given?
          super(progname) { better_log }
        else
          super(better_log)
        end
      end
    end
  end

  module ActionController
    class LogSubscriber < ActiveSupport::LogSubscriber
      def info(progname=nil, &block)
        log = block_given? ? block.call : progname

        better_log = content
                     .sub(/{(.+)}/, '[0m[33m{\1}[0m')
                     .sub(/Processing by ([\w#]+) as ([A-Z]+)/, 'Processing by [0m[32m\1[0m as [0m[30m\2[0m')
                     .sub(/[\w:]+Error/, '[0m[41m\1\2ms[0m')

        if block_given?
          super(progname) { better_log }
        else
          super(better_log)
        end
      end
      alias_method :error, :info
    end
  end

  module ActiveRecord
    class LogSubscriber < ActiveSupport::LogSubscriber
      def debug(progname=nil, &block)
        sql_verb = Regexp.union(%w[UPDATE INSERT DELETE])
        log = block_given? ? block.call : progname

        better_log = content
                     .sub(/(ms\).+)(#{sql_verb}.+)(\[\[(.+)\]\])/m, "\\1[0m[36m\\2[0m\n\\3")
                     .sub(/[\w:]+Error/, '[0m[41m\1\2ms[0m')

        if block_given?
          super(progname) { better_log }
        else
          super(better_log)
        end
      end
    end
  end
end
