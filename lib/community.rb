require 'partial_infection'

# a community is a connected component in a graph
# if one user in a community is infected, then all other
# users in this community will be infected
Community = Struct.new(:size, :members_list) do
end

# a group of communities where we store the size of each
# community
Communities = Struct.new(:sizes_set) do
  include PartialInfection
end
