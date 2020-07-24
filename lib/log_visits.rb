# frozen_string_literal: true

class LogVisits
  attr_reader :path, :visits

  def initialize(path, visits)
    @path = path
    @visits = visits
  end
end
