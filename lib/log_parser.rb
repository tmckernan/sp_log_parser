# frozen_string_literal: true

require_relative 'log_data'

class LogParser
  def initialize(file_loader:)
    @file_loader = file_loader
    @log_data = LogData.new
  end

  def call(file_path)
    file = @file_loader.load(file_path)

    begin
      file.each_line do |log_line|
        add_line(log_line)
      end
    ensure
      file.close
    end

    @log_data
  end

  private

  def add_line(log_line)
    entry = LogEntry.new(log_line)

    @log_data.add_entry(entry)
  end
end
