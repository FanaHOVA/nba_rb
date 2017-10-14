require 'spec_helper'

describe NbaRb::Team do
  it 'loads classes properly' do
    expect(NbaRb::Team::BaseClass).to respond_to(:new)
    expect(NbaRb::Team::Dashboard).to respond_to(:new)
    expect(NbaRb::Team::Lineups).to respond_to(:new)
    expect(NbaRb::Team::InGamesSplits).to respond_to(:new)
  end
end
