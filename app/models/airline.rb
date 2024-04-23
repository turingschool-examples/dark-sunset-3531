class Airline < ApplicationRecord
   has_many :flights
   has_many :passenger_flights, through: :flights
   has_many :passengers, through: :passenger_flights


   def adult_passengers
      self.passengers
      .distinct
      .where('age >= ?', 18)
      # .joins(:flights)
      # .group('passengers.id')
      # .order('count(flights.id) desc')
   end
end