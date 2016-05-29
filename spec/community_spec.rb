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
  let(:mixed_version_community) do
    Community.new([User.new(1), User.new(2, :B, [1])])
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
    expect(valid_community.id).to eq(0)
    expect(Community.new([User.new]).id).to eq(1)
    expect(Community.new([User.new]).id).to eq(2)
  end

  describe '#all_on_version?(version)' do
    it 'returns true if all are on version' do
      expect(valid_community.all_on_version?(:A)).to be true
    end
    it 'returns false if any are not on version' do
      expect(mixed_version_community.all_on_version?(:B)).to be false
    end
  end

  describe '#count_on_version(version)' do
    it 'gives us version counts' do
      expect(mixed_version_community.count_on_version(:A)).to eq(1)
      expect(mixed_version_community.count_on_version(:B)).to eq(1)
    end
  end
end
