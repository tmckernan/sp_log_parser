# frozen_string_literal: true

require 'spec_helper'
require 'parser_cli'
require 'file_loader'
require 'log_parser'
require 'byebug'

describe ParserCli do
  let(:file_path) { 'spec/fixtures/test.log' }
  let(:file_loader) { instance_double(FileLoader) }
  let(:log_parser) { LogParser.new(file_loader: FileLoader.new) }

  subject { described_class.new(parser: log_parser) }

  before do
    allow(STDOUT).to receive(:puts) # this disables puts
  end

  context '#print' do
    it 'display order by visits' do
      expect(subject.print(file_path).first.title).to eq('Urls order by visits (high to low)')
    end

    it 'display order by unique count' do
      expect(subject.print(file_path).last.title).to eq('Urls order by unique count (high to low)')
    end

    context 'list results highest to lowest' do
      let(:table) { subject.print(file_path) }
      it 'all visits' do
        first_value = table.first.rows.first.cells.last.value
        last_value = table.first.rows.last.cells.last.value
        expect(first_value).to be > last_value
      end

      it 'unique visits' do
        first_value = table.last.rows.first.cells.last.value
        last_value = table.last.rows.last.cells.last.value
        expect(first_value).to be > last_value
      end
    end
  end
end
