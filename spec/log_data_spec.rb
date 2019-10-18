# frozen_string_literal: true

require "spec_helper"
require "log_data"

describe LogData do
  let(:path) { 'spec/support/test.log' }
  let(:log_data) { described_class.new(path) }

  context "#counts_ordered_by_urls" do
    let(:results) { [["/help_page/1", 5], ["/home", 3]] }
    subject { log_data.counts_ordered_by_urls }

    it 'return list of visits group by url' do
      expect(subject).to match_array(results)
    end

    context 'no log file' do
      let(:path) { 'missing.log' }
      let(:error_klass) { LogData::LogNotFound }

      it 'return list of visits group by url' do
        expect { subject }.to raise_exception(error_klass)
      end
    end
  end

  context "unique_counts_ordered_by_urls" do
    let(:results) { [["/help_page/1", 4], ["/home", 2]] }
    it 'return unique vists group by url' do
      expect(log_data.unique_counts_ordered_by_urls).to match_array(results)
    end
  end
end
