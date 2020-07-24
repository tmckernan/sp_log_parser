# frozen_string_literal: true

require_relative 'log_data'
require_relative 'log_visits'

class Sorter
  def initialize(visits)
    @visits = visits
  end

  def sort
    @visits.sort { |a, b| b.visits <=> a.visits }
  end
end
