require 'community'
require 'community_array'

class CommunityGraph
  attr_accessor :sizes

  def initialize(communities)
    fail "Must be initialized with [Community]" unless communities.all? {|c| c.is_a? Community }
    @sizes = communities.inject(CommunityArray.new) do |memo, community|
      memo[community.id] = community.size
      memo
    end.compact!
  end

  def size_of(id)
    self.sizes[id - 1]
  end

  def first_id_of(size)
    self.sizes.index(size) + 1
  end
end
