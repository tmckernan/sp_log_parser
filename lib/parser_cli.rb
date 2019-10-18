# frozen_string_literal: true

require "cli_options"
require "log_data"
require 'terminal-table'

class ParserCli
  def self.render(path)
    tables = new.run(path)
    tables.each do |table|
      puts table
    end
  end

  def run(path)
    log_data = LogData.new(path)
    [
      print_table(print_title, log_data.counts_ordered_by_urls),
      print_table(print_title(true), log_data.unique_counts_ordered_by_urls)
    ]
  end

  private

  def headings
    %w[Url Visits]
  end

  def print_table(title, rows)
    Terminal::Table.new(title: title, headings: headings, rows: rows)
  end

  def print_title(unique = false)
    return 'Urls order by unique count (high to low)' if unique

    'Urls order by visits (high to low)'
  end
end
