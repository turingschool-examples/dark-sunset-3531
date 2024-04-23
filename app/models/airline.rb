class Airline < ApplicationRecord
   has_many :flights
   has_many :passengers, through: :flights

   def older_passengers
      passengers.where("age >= ?", 18).distinct
   end
end