require 'spec_helper'
require 'community'

describe Community do
  before(:each) do
    # mocking our communities database
    # and clearing it between runs
    $communities = []
  end
  let(:valid_community) do
    Community.new([User.new])
  end
  it 'needs an array of users' do
    expect { Community.new("bad input") }.to raise_error("Provide members (users) as array")
    expect { Community.new(["bad input"]) }.to raise_error("Every member must be a User")
    expect(valid_community).to be_a Community
  end
  it 'provides the count of the membership' do
    expect(valid_community.size).to eq(1)
  end
  it 'sequences ids from our database' do
    expect(valid_community.id).to eq(1)
    expect(Community.new([User.new]).id).to eq(2)
  end
end
