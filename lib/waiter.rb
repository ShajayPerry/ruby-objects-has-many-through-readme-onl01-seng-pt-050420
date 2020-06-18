class Waiter
    attr_accessor :name, :yrs_experience

    @@all = Array.new

    def initialize(name, yrs_experience)
        @name = name
        @yrs_experience = yrs_experience
        @@all << self
    end

    def self.all
        @@all
    end

    def new_meal(customer, total, tip = 0)
        Meal.new(self, customer, total, tip)
    end

    def meals
        Meal.all.select do |meal|
            meal.waiter == self
        end
    end
    
  

    def customers
        meals.map do |meal|
            meal.customer
        end.map do |customer|
            customer.name
        end.uniq
    end
   def best_tipper
     best_tipped_meal = meals.max do |meal_a, meal_b|
       meal_a.tip <=> meal_b.tip
   end
 
  best_tipped_meal.customer
end
    def highest_tip
        highest_tip = 0
        highest_tipper = nil
        meals.each do |customer|
            if customer.tip > highest_tip
                highest_tip = customer.tip
                highest_tipper = customer
            end
        end
        highest_tipper
    end

    def self.avg_yrs_of_experience
        self.all.collect do |waiter|
            waiter.yrs_experience
        end.reduce(:+) / self.all.size.to_f
    end

    def self.most_experienced_years
        self.all.collect { |waiter| waiter.yrs_experience }[-1]
    end

    def self.least_experienced_years
        self.all.collect { |waiter| waiter.yrs_experience }[0]
    end

    def self.most_experienced_waiter
        most_experienced_waiter = nil
        self.all.select do |waiter|
            if waiter.yrs_experience == self.most_experienced_years
                most_experienced_waiter = waiter
            end
        end
        most_experienced_waiter
    end

    def self.least_experienced_waiter
        least_experienced_waiter = nil
        self.all.select do |waiter|
            if waiter.yrs_experience == self.least_experienced_years
                least_experienced_waiter = waiter
            end
        end
        least_experienced_waiter
    end

    def self.most_experienced_waiter_avg_tips
        (most_experienced_waiter.meals.collect { |meal| meal.tip }.reduce(:+) / most_experienced_waiter.meals.size.to_f).round(2)
    end

    def self.least_experienced_waiter_avg_tips
        (least_experienced_waiter.meals.collect { |meal| meal.tip }.reduce(:+) / least_experienced_waiter.meals.size.to_f).round(2)
    end

    def self.display
        print "Waiters' average years of experience: "
        puts "#{avg_yrs_of_experience}"
        puts "-----"
        print "Most experienced waiter: "
        puts "#{most_experienced_waiter.name}"
        print "Years of experience: "
        puts "#{most_experienced_waiter.yrs_experience}"
        print "Average tip: "
        puts "$#{most_experienced_waiter_avg_tips}"
        puts "-----"
        print "Least experienced waiter: "
        puts "#{least_experienced_waiter.name}"
        print "Years of experience: "
        puts "#{least_experienced_waiter.yrs_experience}"
        print "Average tip: "
        puts "$#{least_experienced_waiter_avg_tips}"
        puts "-----"
        print "#{most_experienced_waiter.name}'s customers: "
        puts "#{most_experienced_waiter.customers}"

        print "#{least_experienced_waiter.name}'s customers: "
        puts "#{least_experienced_waiter.customers}"
    end
end
