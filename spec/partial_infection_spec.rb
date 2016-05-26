require 'spec_helper'

require 'community'

describe 'partial_infection' do
  describe '#doomed_communities' do
    let(:communities) { Communities.new([-3, 1, 2, 6])}
    it 'returns the communities whose populations summed match our target' do
      expect(communities.doomed_subset_upto(0)).to eq([-3,1,2])
    end
  end
end
