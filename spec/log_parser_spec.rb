# frozen_string_literal: true

require 'spec_helper'
require 'log_data'
require 'log_parser'
require 'file_loader'

describe LogParser do
  subject { described_class.new(file_loader: file_loader) }

  let(:file_path) { '' }
  let(:file_loader) { instance_double(FileLoader) }
  let(:file) { StringIO.new(log_line) }
  let(:ip) { '10.10.1.1' }
  let(:path) { '/some/path' }
  let(:log_line) { "#{path} #{ip}" }

  let(:data) do
    {
      path => { ip => 1 }
    }
  end

  describe '#call' do
    before do
      expect(file_loader).to receive(:load).with(file_path).and_return(file)
    end

    it 'returns log data' do
      log_data = subject.call(file_path)
      expect(log_data).to be_an_instance_of(LogData)
      expect(log_data.data).to eq(data)
    end
  end
end
