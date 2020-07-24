# frozen_string_literal: true

require_relative 'log_data'
require_relative 'log_visits'

# Facade which selects a certain counter and calls it
class Counter
  def initialize(log_data)
    @log_data = log_data
  end

  def all_visits
    visits = []

    @log_data.data.each do |path, ips|
      visits << LogVisits.new(path, ips.values.reduce(&:+))
    end
    visits
  end

  def unique_visits
    visits = []

    @log_data.data.each do |path, ips|
      visits << LogVisits.new(path, ips.keys.count)
    end

    visits
  end
end
