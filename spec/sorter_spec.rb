# frozen_string_literal: true

require 'spec_helper'
require 'log_visits'
require 'sorter'

describe Sorter do
  subject { described_class.new(visits) }
  let(:path_1) { '/some/path1' }
  let(:path_2) { '/some/path2' }

  describe '.sort' do
    let(:log_visits_1) do
      instance_double(LogVisits, path: path_1, visits: 3)
    end

    let(:log_visits_2) do
      instance_double(LogVisits, path: path_2, visits: 5)
    end

    let(:visits) do
      [
        log_visits_1,
        log_visits_2
      ]
    end

    it 'return visits ordered from most pages views to less page views' do
      expect(subject.sort).to eq [log_visits_2, log_visits_1]
    end
  end
end
