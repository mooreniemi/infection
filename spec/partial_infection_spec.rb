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
      it 'trims list of elements within tolerance' do
        array = [10, 11, 12, 15, 20, 21, 22, 23, 24, 29]
        epsilon = 0.1
        trimmed_array = [10, 12, 15, 20, 23, 29]

        expect(array.trim_by!(epsilon)).to eq(trimmed_array)
      end
    end
    it 'handles Cormen case' do
      medium_community = CommunityArray.new([104, 102, 201, 101])
      expect(medium_community.approximate_doomed_subset_upto(308, 0.40)).
        to match_array([101,104,201])
    end
    it 'can handle larger numbers' do
      expect(big_community_array.approximate_doomed_subset_upto(9105)).to eq([])
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
