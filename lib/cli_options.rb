# frozen_string_literal: true

require "optparse"

class CLIOptions
  def initialize(args = [])
    @options = parse_args(args)
  end

  def path
    @options.fetch(:file_path)
  end

  private

  def parse_args(args)
    opts = {}

    OptionParser.new.tap do |parser|
      parser.on("-p", "--path [PATH]") do |file_path|
        opts[:file_path] = String(file_path)
      end

      parser.parse(args)
    end

    opts
  end
end
