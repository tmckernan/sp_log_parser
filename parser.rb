#!/usr/bin/env ruby
# frozen_string_literal: true

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "lib"))
require "parser_cli"
@options = CLIOptions.new(ARGV)
ParserCli.render(@options.path)
