require 'user'

# corresponds to a Connected Component
class Community
  attr_accessor :id
  attr_accessor :size, :members

  def initialize(members)
    fail "Provide members (users) as array" unless members.is_a? Array
    fail "Every member must be a User" unless members.all? {|e| e.is_a? User }
    @id = $communities.size
    @members = members
    @size = members.size
    $communities[@id] = self
  end

  def all_on_version?(version)
    members.all? {|u| u.version == version }
  end

  def count_on_version(version)
    members.count {|u| u.version == version }
  end
end
