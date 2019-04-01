require 'pry'
require 'csv'
class StatTracker
  def initialize(argument)

  end
  def self.from_csv(hash)
    CSV.open(hash[:games]) do |row|
    binding.pry
    end
  end
end
