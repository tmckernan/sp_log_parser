# frozen_string_literal: true

require 'log_data'
require 'terminal-table'
require 'sorter'
require 'counter'

class ParserCli
  HEADING = %w[Url Visits].freeze
  ALL_VISITS_TITLE = 'Urls order by visits (high to low)'
  UNIQUE_VISITS_TITLE = 'Urls order by unique count (high to low)'

  attr_reader :log_data

  def initialize(parser:)
    @parser = parser
    @log_data = {}
  end

  def print(file_path)
    @log_data = @parser.call(file_path)
    tables = table_data
    tables.each do |table|
      puts table
    end
  end

  private

  def counter
    @counter ||= Counter.new(@log_data)
  end

  def sorter(visits)
    Sorter.new(visits).sort
  end

  def row_data(values)
    values.map do |value|
      [value.path, value.visits]
    end
  end

  def table_data
    [
      print_table(ALL_VISITS_TITLE, row_data(sorter(counter.all_visits))),
      print_table(UNIQUE_VISITS_TITLE, row_data(sorter(counter.unique_visits)))
    ]
  end

  def print_table(title, rows)
    Terminal::Table.new(title: title, headings: HEADING, rows: rows)
  end
end
