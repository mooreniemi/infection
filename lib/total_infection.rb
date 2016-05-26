module TotalInfection
  # BFS(G, s)
  # where s is defined by self
  # and G is $users
  def infect!
    health = []

    # dependent on our store to access other users
    $users.each do |user|
      next if user.id == self.id # ignore our starting node
      health[user.id] = "unexposed"
    end

    health[self.id] = "exposed"
    queue = []

    queue.push(self)
    while !queue.empty?
      user = queue.shift
      return if health[user.id] == "infected"

      # the result of infection is the version change
      user.version = :B

      user.adjacent_users.each do |adj_user_id|
        if health[adj_user_id] == "unexposed"
          health[adj_user_id] = "exposed"
        end

        $users[adj_user_id].version = :B
        queue.push($users[adj_user_id])
      end

      health[user.id] = "infected"
    end
  end
end
