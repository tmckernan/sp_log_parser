# frozen_string_literal: true

require 'byebug'
require 'errors'
class FileLoader
  def load(file_path)
    raise Errors::StandardFileError, 'No file path provided' if file_path.nil? || file_path.empty?

    File.new(file_path, 'r') if file_exists?(file_path)
  end

  private

  def file_exists?(file_path)
    return true if File.exist?(file_path)

    raise Errors::FileNotFoundError, "File not found [#{file_path}]"
  end
end
