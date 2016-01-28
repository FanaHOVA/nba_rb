require 'spec_helper'

describe 'Games endpoints' do
  it 'has working Boxscore endpoint' do
    request = Boxscore.new(game_id: '0041400122')
    expect(request.data).to_not eq(nil)
  end

  it 'has working BoxscoreScoring endpoint' do
    request = BoxscoreScoring.new(game_id: '0041400122')
    expect(request.data).to_not eq(nil)
  end

  it 'has working BoxscoreUsage endpoint' do
    request = BoxscoreUsage.new(game_id: '0041400122')
    expect(request.data).to_not eq(nil)
  end

  it 'has working BoxscoreAdvanced endpoint' do
    request = BoxscoreAdvanced.new(game_id: '0041400122')
    expect(request.data).to_not eq(nil)
  end

  it 'has working BoxscoreFourFactors endpoint' do
    request = BoxscoreFourFactors.new(game_id: '0041400122')
    expect(request.data).to_not eq(nil)
  end
end
