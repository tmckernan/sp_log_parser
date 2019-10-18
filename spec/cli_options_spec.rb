# frozen_string_literal: true

require "spec_helper"
require "cli_options"

describe CLIOptions do
  context "with '--path  /support/test.txt'" do
    let(:file_path) { "spec/support/test.txt" }
    let(:args) { ["--path", file_path] }
    subject { CLIOptions.new(args) }

    it "contain file path " do
      expect(subject.path).to eql(file_path)
    end
  end
end
