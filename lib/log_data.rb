# frozen_string_literal: true

require_relative 'log_visit'

class LogData
  class LogNotFound < StandardError
    def initialize(msg = 'No log file')
      super
    end
  end

  attr_reader :path, :log_visits

  def initialize(path)
    @path = path
    @log_visits = parse_file
  end

  def counts_ordered_by_urls
    sort_urls(urls_count)
  end

  def unique_counts_ordered_by_urls
    sort_urls(url_unique_counts)
  end

  private

  def parse_file
    begin
      File.open(path, 'r').each_line.map do |line|
        url, ip = line.split
        LogVisit.new(url: url, ip_address: ip)
      end
    end
  rescue Errno::ENOENT
    raise LogNotFound
  end

  def group_by_urls
    @group_by_urls ||= log_visits.group_by(&:url)
  end

  def urls_count
    group_by_urls.map do |url, visits|
      [url, visits.count]
    end
  end

  def url_unique_counts
    group_by_urls.map do |key, value|
      [key, value.map(&:ip_address).uniq.count]
    end
  end

  def sort_urls(values)
    values.sort { |a, b| b.last <=> a.last }
  end
end
