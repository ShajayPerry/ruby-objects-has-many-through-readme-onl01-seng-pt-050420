
class Meal
    attr_accessor :customer, :waiter, :total, :tip

    @@all = Array.new

    def initialize(waiter, customer, total, tip = 0)
        @waiter = waiter
        @customer = customer
        @total = total
        @tip = tip
        @@all << self
    end

    def self.all
        @@all
    end
end