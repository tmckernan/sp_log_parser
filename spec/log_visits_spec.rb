# frozen_string_literal: true

require 'spec_helper'
require 'log_visits'

describe LogVisits do
  context 'initialize' do
    let(:visits) { 5 }
    let(:path) { '/home' }
    let(:log_visit) { described_class.new(path, visits) }

    it 'should contain a path ' do
      expect(log_visit.path).to eq(path)
    end

    it 'should contain number of visits' do
      expect(log_visit.visits).to eq(visits)
    end
  end
end
