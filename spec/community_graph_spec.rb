require 'spec_helper'
require 'community_graph'

describe CommunityGraph do
  before(:each) do
    # mocking our communities database
    # and clearing it between runs
    $communities = []
    $users = []
  end
  let!(:communities) do
    [
      Community.new([User.new(1)]),
      Community.new(
        [
          User.new(2, :A, [3]),
          User.new(3, :A, [2])
        ]
      ),
      Community.new(
        [
          User.new(4, :A, [5]),
          User.new(5, :A, [4,6]),
          User.new(6, :A, [5])
        ])
    ]
  end
  let(:valid_community_graph) do
    CommunityGraph.new(communities)
  end
  it 'requires an array of communities' do
    expect { CommunityGraph.new(["bad input"]) }.
      to raise_error "Must be initialized with [Community]"
    expect(valid_community_graph).to be_a CommunityGraph
  end
  it 'gives CommunityArray of sizes' do
    expect(valid_community_graph.sizes).to eq([1,2,3])
  end
  it 'sizes and ids should be equal in size' do
    expect(valid_community_graph.sizes.size).to eq(valid_community_graph.ids.size)
  end
  it '#size_of(id)' do
    expect(valid_community_graph.size_of(0)).to eq(1)
  end
  it '#first_id_of(size)' do
    expect(valid_community_graph.first_id_of(2)).to eq(1)
  end

  context 'can be infected totally or partially' do
    describe '#total_infection' do
      it 'switches all users from version :A to version :B' do
        before_infection = valid_community_graph.ids.all? {|id| $communities[id].all_on_version?(:A) }
        valid_community_graph.total_infection
        after_infection = valid_community_graph.ids.all? {|id| $communities[id].all_on_version?(:B) }
        expect(before_infection).to eq(true)
        expect(after_infection).to eq(true)
      end
    end
  end
end
