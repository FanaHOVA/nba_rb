require 'helpers/initialize'
require 'nba_rb/version'
require 'nba_rb/constants'
require 'nba_rb/game'
require 'nba_rb/player'
require 'nba_rb/team'
require 'net/http'
require 'json'

module NbaRb
  BASE_URL = 'http://stats.nba.com/stats/'
  CURRENT_SEASON = '2015-16'
end
