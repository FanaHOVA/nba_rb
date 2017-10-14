require 'spec_helper'

describe 'Players endpoints' do
  it 'has working PlayerSummary endpoint' do
    request = NbaRb::Player::Summary.new(player_id: '203507')
    expect(request.data).to_not eq(nil)
  end

  it 'has working PlayerCareer endpoint' do
    request = NbaRb::Player::Career.new(player_id: '203507')
    expect(request.data).to_not eq(nil)
  end

  it 'has working PlayerList endpoint' do
    request = NbaRb::Player::List.new
    expect(request.data).to_not eq(nil)
  end
end
