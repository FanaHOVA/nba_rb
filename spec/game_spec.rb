require 'spec_helper'

describe 'Games endpoints' do
  it 'has working Boxscore endpoint' do
    boxscore = NbaRb::Game::Boxscore.new(game_id: '0041400122')
    expect(boxscore.data).to_not eq(nil)
    expect(boxscore.endpoint).to eq('boxscoretraditionalv2')
    expect(boxscore.game_summary).to_not eq(nil)
    expect(boxscore.line_score).to_not eq(nil)
    expect(boxscore.season_series).to_not eq(nil)
    expect(boxscore.last_meeting).to_not eq(nil)
    expect(boxscore.player_stats).to_not eq(nil)
    expect(boxscore.team_stats).to_not eq(nil)
    expect(boxscore.other_stats).to_not eq(nil)
    expect(boxscore.officials).to_not eq(nil)
    expect(boxscore.game_info).to_not eq(nil)
    expect(boxscore.inactive_players).to_not eq(nil)
    expect(boxscore.available_video).to_not eq(nil)
    expect(boxscore.player_track).to_not eq(nil)
    expect(boxscore.player_track_team).to_not eq(nil)
  end

  it 'has working BoxscoreScoring endpoint' do
    boxscore_scoring = NbaRb::Game::BoxscoreScoring.new(game_id: '0041400122')
    expect(boxscore_scoring.data).to_not eq(nil)
    expect(boxscore_scoring.endpoint).to eq('boxscorescoringv2')
    expect(boxscore_scoring.players_scoring).to_not eq(nil)
    expect(boxscore_scoring.team_scoring).to_not eq(nil)
  end

  it 'has working BoxscoreUsage endpoint' do
    boxscore_usage = NbaRb::Game::BoxscoreUsage.new(game_id: '0041400122')
    expect(boxscore_usage.data).to_not eq(nil)
    expect(boxscore_usage.endpoint).to eq('boxscoreusagev2')
    expect(boxscore_usage.players_usage).to_not eq(nil)
    expect(boxscore_usage.team_usage).to_not eq(nil)
  end

  it 'has working BoxscoreAdvanced endpoint' do
    boxscore_advanced = NbaRb::Game::BoxscoreAdvanced.new(game_id: '0041400122')
    expect(boxscore_advanced.data).to_not eq(nil)
    expect(boxscore_advanced.endpoint).to eq('boxscoreadvancedv2')
    expect(boxscore_advanced.players_advanced).to_not eq(nil)
    expect(boxscore_advanced.team_advanced).to_not eq(nil)
  end

  it 'has working BoxscoreFourFactors endpoint' do
    four_factors = NbaRb::Game::BoxscoreFourFactors.new(game_id: '0041400122')
    expect(four_factors.data).to_not eq(nil)
    expect(four_factors.endpoint).to eq('boxscorefourfactorsv2')
    expect(four_factors.players_four_factors).to_not eq(nil)
    expect(four_factors.team_four_factors).to_not eq(nil)
  end

  it 'has working Scoreboard endpoint' do
    scoreboard = NbaRb::Game::Scoreboard.new
    expect(scoreboard.data).to_not eq(nil)
    expect(scoreboard.endpoint).to eq('scoreboardV2')
    expect(scoreboard.series_standings.class).to eq Array
    expect(scoreboard.matchup_teams_info.class).to eq Array
    expect(scoreboard.arena_and_tv_info.class).to eq Array
    expect(scoreboard.last_meeting.class).to eq Array
    expect(scoreboard.eastern_conference_standings_today.class).to eq Array
    expect(scoreboard.western_conference_standings_today.class).to eq Array
  end
end
