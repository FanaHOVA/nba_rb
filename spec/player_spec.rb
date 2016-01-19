require 'spec_helper'

describe 'Players endpoints' do
  it 'has working PlayerDashboard endpoint' do
    request = PlayerDashboard.new(player_id: '203507')
    expect(request.data).to_not eq(nil)
  end

  it 'has working PlayerInfoCommon endpoint' do
    request = PlayerInfoCommon.new(player_id: '203507')
    expect(request.data).to_not eq(nil)
  end

  it 'has working PlayerCareerStats endpoint' do
    request = PlayerCareer.new(player_id: '203507')
    expect(request.data).to_not eq(nil)
  end

  it 'has working PlayerList endpoint' do
    request = PlayerList.new
    expect(request.data).to_not eq(nil)
  end
end
