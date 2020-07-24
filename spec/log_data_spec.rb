# frozen_string_literal: true

require 'spec_helper'
require 'log_data'

describe LogData do
  let(:path) { '/some/endpoint' }
  let(:ip) { '1.2.3.4' }
  let(:log_entry) { instance_double(LogEntry, path: path, ip: ip) }

  describe '#add_entry' do
    context 'when entry exists' do
      subject { described_class.new(path => { ip => 1 }) }

      it 'increments visits count' do
        subject.add_entry(log_entry)
        expect(subject.data[path][ip]).to eq 2
      end
    end

    context "when entry doesn't exist" do
      it 'adds the entry with one visit' do
        subject.add_entry(log_entry)
        expect(subject.data[path][ip]).to eq 1
      end
    end
  end
end
