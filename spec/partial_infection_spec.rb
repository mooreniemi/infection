require 'spec_helper'

require 'community_array'

describe 'partial_infection' do
  using PartialInfection
  let(:good_community_array) { CommunityArray.new([3,34,4,12,5,2])}
  let(:bad_community_array) { CommunityArray.new([2,3])}
  let(:big_community_array) { CommunityArray.new([2000,3000,12000,5000,4000,34000])}

  describe '#approximate_doomed_subset_upto' do
    context 'relies on trimming "close enough" elements' do
      using Trim
      it 'allows a properly formed Hash to trim' do
        hash = {0 => [0, 2]}
        trimmed_hash = {0 => [0]}
        expect(hash.trim(2)).to eq(trimmed_hash)
      end
    end
  end

  describe '#doomed_subset_upto' do
    it 'returns the community sizes when summed reach our target' do
      expect(good_community_array.doomed_subset_upto(9)).to match_array([4,5])
    end
    it 'returns false if we cant reach the sum with our current communities' do
      expect(bad_community_array.doomed_subset_upto(6)).to eq(false)
    end
    it 'is exact but very slow for larger numbers' do
      time = Time.new
      puts "starting at #{time.hour}:#{time.min} this will take roughly 2 minutes to solve, so hold tight :)"
      expect(big_community_array.doomed_subset_upto(9000)).to match_array([2000,3000,4000])

      # puts "starting at #{time.hour}:#{time.min} this performance test will take 10 minutes minimum!"
      #expect { big_community_array.doomed_subset_upto(9000) }.
      #  to perform_under(10).min.and_sample(10)
    end
  end
end
