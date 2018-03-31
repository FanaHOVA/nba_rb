require 'helpers/initialize'
require 'helpers/stats_hash'
require 'httparty'
require 'helpers/stats_request'
require 'nba_rb/version'
require 'nba_rb/constants'
require 'nba_rb/game'
require 'nba_rb/player'
require 'nba_rb/team'
require 'net/http'
require 'json'

module NbaRb
  BASE_URL = 'http://stats.nba.com/stats/'.freeze
  CURRENT_SEASON = '2017-18'.freeze
end
