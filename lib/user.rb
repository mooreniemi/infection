require 'total_infection'

User = Struct.new(:id, :version, :adjacent_users) do
  include TotalInfection

  def initialize(id=SecureRandom.random_number(100), version=:A, adjacent_users=[])
    super
  end
end
