require 'spec_helper'

describe NbaRb do
  it 'has a version number' do
    expect(NbaRb::VERSION).not_to be nil
  end

  it 'has a current season' do
    expect(NbaRb::CURRENT_SEASON).to eq('2017-18')
  end

  it 'has a base url' do
    expect(NbaRb::BASE_URL).to eq('http://stats.nba.com/stats/')
  end
end
