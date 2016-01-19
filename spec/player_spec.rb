require 'spec_helper'

describe 'Players endpoints' do
  it 'has working PlayerSummary endpoint' do
    request = PlayerSummary.new(player_id: '203507')
    expect(request.data).to_not eq(nil)
  end

  it 'has working PlayerCareer endpoint' do
    request = PlayerCareer.new(player_id: '203507')
    expect(request.data).to_not eq(nil)
  end

  it 'has working PlayerList endpoint' do
    request = PlayerList.new
    expect(request.data).to_not eq(nil)
  end
end
