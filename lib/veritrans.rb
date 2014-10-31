require 'veritrans/version'
require 'veritrans/config'
require 'veritrans/client'
require 'veritrans/api'
require 'veritrans/result'


module Veritrans
  extend Veritrans::Client
  extend Veritrans::Api

  class << self
    def config(&block)
      if block
        instance_eval(&block)
      else
        Veritrans::Config
      end
    end

    alias_method :setup, :config

    def logger=(value)
      @logger = value
    end

    def logger
      return @logger if @logger
      if defined?(Rails)
        Rails.logger
      else
        unless @log
          require 'logger'
          @log = Logger.new(STDOUT)
          @log.level = Logger::INFO
        end
        @log
      end
    end

  end
end
