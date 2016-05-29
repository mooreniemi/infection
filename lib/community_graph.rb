require 'community'
require 'community_array'
require 'partial_infection'

class CommunityGraph
  using PartialInfection
  attr_accessor :sizes
  attr_accessor :ids

  def initialize(communities)
    fail "Must be initialized with [Community]" unless communities.all? {|c| c.is_a? Community }
    @sizes = communities.inject(CommunityArray.new) do |memo, community|
      memo[community.id] = community.size
      memo
    end
    @ids = (0..sizes.size - 1).to_a
  end

  def size_of(id)
    self.sizes[id]
  end

  def first_id_of(size)
    self.sizes.index(size)
  end

  def total_infection
    ids.each do |id|
      # as long as we infect one member in the community
      # all will become infected
      $communities[id].members.first.infect!
    end
  end

  def partial_infection_of(number_users, margin_of_error)
    fail "margin_of_error should be a float" unless margin_of_error.is_a? Float
    best_fit = sizes.approximate_doomed_subset_upto(number_users, margin_of_error)
    doomed_communities = best_fit.inject([]) do |memo, e|
      memo << first_id_of(e)
      memo
    end

    doomed_communities.each do |community_id|
      $communities[community_id].members.first.infect!
    end
  end

  def infect_exactly(number_users)
  end
end
