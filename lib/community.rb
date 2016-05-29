require 'user'

# corresponds to a Connected Component
class Community
  attr_accessor :id
  attr_accessor :size, :members

  def initialize(members)
    fail "Provide members (users) as array" unless members.is_a? Array
    fail "Every member must be a User" unless members.all? {|e| e.is_a? User }
    @id = $communities.size + 1
    $communities << @id
    @members = members
    @size = members.size
  end
end
