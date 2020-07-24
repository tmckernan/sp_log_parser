# frozen_string_literal: true

require 'spec_helper'
require 'file_loader'
require 'errors'

describe FileLoader do
  describe '#load' do
    subject { described_class.new }

    context 'no file path' do
      it { expect { subject.load(nil) }.to raise_error Errors::StandardFileError }
    end

    context 'file dose not exist' do
      let(:file_path) { 'spec/logfiles/not_exist/somefile.log' }
      it { expect { subject.load(file_path) }.to raise_error Errors::FileNotFoundError }
    end

    context 'valid file path' do
      let(:file_path) { 'spec/fixtures/test.log' }

      it 'opens a file' do
        expect(subject.load(file_path)).to be_an_instance_of(File)
      end
    end
  end
end
