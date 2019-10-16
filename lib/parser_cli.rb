# frozen_string_literal: true

require "cli_options"
require "log_data"
require 'terminal-table'

class ParserCli
  def self.run
    new.run
  end

  def run
    log_data = LogData.new(options.path)
    puts print_table(print_title, log_data.counts_ordered_by_urls)
    puts print_table(print_title(true), log_data.unique_counts_ordered_by_urls)
  end

  private

  def options
    @options ||= CLIOptions.new(ARGV)
  end

  def headings
    %w[Url Visits]
  end

  def print_table(title, rows)
    Terminal::Table.new(title: title, headings: headings, rows: rows)
  end

  def print_title(unique = false)
    'Urls order by unique count (high to low)' if unique

    'Urls order by visits (high to low)'
  end
end
