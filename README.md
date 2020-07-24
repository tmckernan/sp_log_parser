# LogParser
Parser a log file

## Description

Write a ruby script that:

a. Receives a log as argument (webserver.log is provided)

     e.g.: ./parser.rb webserver.log

b. Returns the following:

list of webpages with most page views ordered from most pages views to less page views

     e.g.:
         /home 90 visits
         /index 80 visits
         etc...
list of webpages with most unique page views also ordered

     e.g.:
         /about/2   8 unique views
         /index     5 unique views
         etc.

# Approach

Each Line in the logfile is parse into `LogData`.

The log file is praser in the following steps:

1. A line of the logfile is passed to the `LogEntry` object.

2. The `LogEntry` object is saved to the `LogData`

    The LogData has the following structure
    `{ <path> => { <ip> => <visits> } }`

3. `Counter` calulated the number of visits by accepeting the parser data from `LogData` and returning an array of `LogVisits`.

- `Logvisits` is a simple value object which holds path and number of visits.

4. `Sorter` accepts an Array of `LogVisits` objects and return sorted array of objects from highest to lowest visits.

5. `ParserCli` prints the following two tables:
  - All visits to a given path order by high to low visits
  - Unique visits to a given path order by high to low visits

# Usage
## Install
  1. Clone the repository
  2. run `bundle install` to install gems

## Test
  - Run specs: `bundle exec rspec`
  - Run linter: `bundle exec rubocop`

## Run Working example

      `./parser.rb webserver.log`

      +------------------+-----------------+
      | Urls order by visits (high to low) |
      +------------------+-----------------+
      | Url              | Visits          |
      +------------------+-----------------+
      | /about/2         | 90              |
      | /contact         | 89              |
      | /index           | 82              |
      | /about           | 81              |
      | /help_page/1     | 80              |
      | /home            | 78              |
      +------------------+-----------------+
      +---------------------+--------------------+
      | Urls order by unique count (high to low) |
      +---------------------+--------------------+
      | Url                 | Visits             |
      +---------------------+--------------------+
      | /help_page/1        | 23                 |
      | /contact            | 23                 |
      | /home               | 23                 |
      | /index              | 23                 |
      | /about/2            | 22                 |
      | /about              | 21                 |
      +---------------------+--------------------+

