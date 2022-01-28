# frozen_string_literal: true

require 'logger'

module LoggerHelper
  def log_info(message)
    log = Logger.new($stdout)
    log.info(message)
  end

  def log_error(message)
    error_log = Logger.new($stderr)
    error_log.error(message)
  end
end
