#!/usr/bin/env ruby
# frozen_string_literal: true

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'lib'))
require 'parser_cli'
require 'log_parser'
require 'file_loader'

log_parser = LogParser.new(file_loader: FileLoader.new)

log_parser = ParserCli.new(parser: log_parser)

log_parser.print(ARGV[0])
