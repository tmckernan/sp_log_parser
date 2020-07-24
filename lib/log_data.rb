# frozen_string_literal: true

require_relative 'log_entry'

class LogData
  attr_reader :data

  def initialize(data = {})
    @data = data
  end

  def add_entry(entry)
    paths = @data[entry.path]

    return @data[entry.path] = Hash[entry.ip, 1] if paths.nil?

    paths[entry.ip].nil? ? paths[entry.ip] = 1 : paths[entry.ip] += 1
  end
end
