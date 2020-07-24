# frozen_string_literal: true

class LogEntry
  attr_reader :path, :ip

  def initialize(log_entry)
    @path, @ip = log_entry.split
  end
end
