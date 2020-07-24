# frozen_string_literal: true

require 'spec_helper'
require 'log_data'
require 'log_visits'
require 'counter'
require 'byebug'

describe Counter do
  subject { described_class.new(log_data) }
  let(:ip_address_1) { '10.10.10.1' }
  let(:ip_address_2) { '10.10.10.2' }
  let(:path_1) { '/some/path1' }
  let(:path_2) { '/some/path2' }

  let(:log_data) do
    instance_double(LogData, data: data)
  end

  before do
    expect(LogVisits).to receive(:new).with(path_1, visits).and_return(log_visits)
  end

  let(:log_visits) do
    instance_double(LogVisits, path: path_1, visits: visits)
  end

  describe '.all_visits' do
    context 'one path from the same ip' do
      let(:data) { { path_1 => { ip_address_1 => 2 } } }
      let(:visits) { 2 }
      it { expect(subject.all_visits).to eq [log_visits] }
    end

    context 'one path from the multiple ip' do
      let(:visits) { 3 }
      let(:data) { { path_1 => { ip_address_1 => 2, ip_address_2 => 1 } } }
      it { expect(subject.all_visits).to eq [log_visits] }
    end

    context 'two paths from the multiple ip' do
      let(:visits) { 3 }
      let(:log_visits_2) { instance_double(LogVisits, path: path_2, visits: visits) }
      let(:data) do
        {
          path_1 => { ip_address_1 => 2, ip_address_2 => 1 },
          path_2 => { ip_address_1 => 1, ip_address_2 => 2 }
        }
      end

      before do
        expect(LogVisits).to receive(:new).with(path_2, visits).and_return(log_visits_2)
      end

      it { expect(subject.all_visits).to eq [log_visits, log_visits_2] }
    end
  end

  describe '.unique_visits' do
    context 'one path from the same ip' do
      let(:data) { { path_1 => { ip_address_1 => 1 } } }
      let(:visits) { 1 }
      it { expect(subject.unique_visits).to eq [log_visits] }
    end

    context 'one path from the same ip several times' do
      let(:data) { { path_1 => { ip_address_1 => 2 } } }
      let(:visits) { 1 }
      it { expect(subject.unique_visits).to eq [log_visits] }
    end

    context 'one path from the two different ips' do
      let(:data) { { path_1 => { ip_address_1 => 2, ip_address_2 => 37 } } }
      let(:visits) { 2 }
      it { expect(subject.unique_visits).to eq [log_visits] }
    end

    context 'two paths from the multiple ips' do
      let(:visits) { 2 }
      let(:log_visits_2) { instance_double(LogVisits, path: path_2, visits: visits) }
      let(:data) do
        {
          path_1 => { ip_address_1 => 2, ip_address_2 => 1 },
          path_2 => { ip_address_1 => 1, ip_address_2 => 2 }
        }
      end
      before do
        expect(LogVisits).to receive(:new).with(path_2, visits).and_return(log_visits_2)
      end

      it { expect(subject.unique_visits).to eq [log_visits, log_visits_2] }
    end
  end
end
