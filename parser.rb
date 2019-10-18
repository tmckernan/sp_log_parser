#!/usr/bin/env ruby
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "lib"))
require "parser_cli"
@options = CLIOptions.new(ARGV)
ParserCli.render(@options.path)
