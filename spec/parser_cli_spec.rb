# frozen_string_literal: true

require "spec_helper"
require "parser_cli"

describe ParserCli do
  let(:file_path) { 'spec/support/test.log' }
  subject { described_class.new.run(file_path) }
  context "#run" do
    it "return terminal-tables" do
      expect(subject.count).to eq(2)
      expect(subject.first).to be_an_instance_of(Terminal::Table)
    end

    it 'display order by visits' do
      expect(subject.first.title).to eq('Urls order by visits (high to low)')
    end

    it 'display order by unique count' do
      expect(subject.last.title).to eq('Urls order by unique count (high to low)')
    end
  end
end
