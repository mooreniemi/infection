User = Struct.new(:id, :version, :adjacent_users) do
  def initialize(id=SecureRandom.random_number(100), version=:A, adjacent_users=[])
    super
  end

  # BFS(G, s)
  # where s is defined by self
  def infect!
    state = []
    parent = []

    $users.each do |user|
      next if user.id == self.id # ignore our starting node
      state[user.id] = "undiscovered"
      parent[user.id] = nil
    end

    state[self.id] = "discovered"
    parent[self.id] = nil
    queue = []

    queue.push(self)
    while !queue.empty?
      user = queue.shift
      return if state[user.id] == "processed"
      user.version = :B
      user.adjacent_users.each do |adj_user_id|
        if state[adj_user_id] == "undiscovered"
          state[adj_user_id] = "discovered"
          parent[adj_user_id] = user.id
        end

        $users[adj_user_id].version = :B
        queue.push($users[adj_user_id])
      end

      state[user.id] = "processed"
    end
  end
end
