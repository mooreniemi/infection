require 'community'
require 'community_array'

class CommunityGraph
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
      # binding.pry
      $communities[id].members.first.infect!
    end
  end

  def partial_infection_of(number_users, margin_of_error)
  end

  def partial_infection_of(number_users)
  end
end
