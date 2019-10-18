# frozen_string_literal: true

require "spec_helper"
require "log_visit"

describe LogVisit do
  context 'initialize' do
    let(:ip_address) { '10.1.0.12' }
    let(:url) { '/home' }
    let(:log_visit) { described_class.new(url: url, ip_address: ip_address) }

    it 'should contain a url ' do
      expect(log_visit.url).to eq('/home')
    end

    it 'should contain an ip_address' do
      expect(log_visit.ip_address).to eq('10.1.0.12')
    end
  end
end
