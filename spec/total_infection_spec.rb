require 'spec_helper'

require 'user'

describe "total_infection" do
  describe User do
    let(:user) { User.new }
    it 'allows access to #id and #version' do
      expect(user.id).to_not eq(nil)
      expect(user.version).to eq(:A)
    end
    it 'has a list of #adjacent_users' do
      user.adjacent_users = [2, 3, 4]
      expect(user.adjacent_users).to eq([2, 3, 4])
    end
  end

  describe "#infect!" do
    before(:each) do
      # clear out our "database"
      $users = []
    end

    it 'toggles the version seen by a user from A to B' do
      $users << (user = User.new)
      user.infect!
      expect(user.version).to eq(:B)
    end

    it 'spreads the infection to any users in the adjacent_users' do
      patient_zero = User.new(0, :A, [1])
      patient_one = User.new(1, :A, [0])

      $users = [patient_zero, patient_one]
      patient_zero.infect!
      expect(patient_one.version).to eq(:B)
    end

    it 'spreads transitively' do
      patient_a = User.new(0, :A, [1])
      patient_b = User.new(1, :A, [0,2])
      patient_c = User.new(2, :A [1])

      $users = [patient_a, patient_b, patient_c]

      patient_a.infect!
      expect(patient_c.version).to eq(:B)
    end

    it 'spreads commutatively' do
      patient_a = User.new(0, :A, [1])
      patient_b = User.new(1, :A, [0,2])
      patient_c = User.new(2, :A, [1])

      $users = [patient_a, patient_b, patient_c]

      patient_c.infect!
      expect(patient_a.version).to eq(:B)
    end
  end
end
