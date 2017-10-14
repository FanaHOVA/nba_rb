require 'spec_helper'

describe 'Games endpoints' do
  it 'has working Boxscore endpoint' do
    request = NbaRb::Game::Boxscore.new(game_id: '0041400122')
    expect(request.data).to_not eq(nil)
  end

  it 'has working BoxscoreScoring endpoint' do
    request = NbaRb::Game::BoxscoreScoring.new(game_id: '0041400122')
    expect(request.data).to_not eq(nil)
  end

  it 'has working BoxscoreUsage endpoint' do
    request = NbaRb::Game::BoxscoreUsage.new(game_id: '0041400122')
    expect(request.data).to_not eq(nil)
  end

  it 'has working BoxscoreAdvanced endpoint' do
    request = NbaRb::Game::BoxscoreAdvanced.new(game_id: '0041400122')
    expect(request.data).to_not eq(nil)
  end

  it 'has working BoxscoreFourFactors endpoint' do
    request = NbaRb::Game::BoxscoreFourFactors.new(game_id: '0041400122')
    expect(request.data).to_not eq(nil)
  end
end
