require './lib/nba_rb/version'
require './lib/nba_rb/constants'
require './lib/nba_rb/game'
require './lib/nba_rb/player'
require './lib/nba_rb/team'
require 'net/http'
require 'json'

module NbaRb
  BASE_URL = 'http://stats.nba.com/stats/'
  CURRENT_SEASON = '2015-16'
end
