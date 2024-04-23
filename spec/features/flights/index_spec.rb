require "rails_helper"

RSpec.describe "Flights Index Page" do
  before(:each) do
    @ar1 = Airline.create!(name: "United")

    @f1 = @ar1.flights.create!(number: "1234", date:"01/02/03", departure_city: "Denver", arrival_city: "PVR")
    @f2 = @ar1.flights.create!(number: "4321", date:"01/22/33", departure_city: "Cali", arrival_city: "KC")
    @f3 = @ar1.flights.create!(number: "5678", date:"01/23/33", departure_city: "Utah", arrival_city: "Denver")

    @p1 = Passenger.create!(name:"Martin", age: 21, flights_id: @f1.id)
    @p2 = Passenger.create!(name:"Rodrigo", age: 19, flights_id: @f1.id)
    @p3 = Passenger.create!(name:"Ezequiel", age: 18, flights_id: @f1.id)

    @f1.passengers << [@p1, @p2]
    @f2.passengers << [@p2]
    @f3.passengers << [@p3]

    

  end

  describe '#us 1' do
    it 'Displays all flights attributes' do
      # When I visit the flights index page
      visit flights_path
      # I see a list of all flight numbers
      expect(page).to have_content("Flight Number: 1234")
      expect(page).to have_content("Airline: United")
      expect(page).to have_content("Passenger Name: Martin")
      expect(page).to have_content("Passenger Name: Rodrigo")

      expect(page).to have_content("Flight Number: 4321")
      expect(page).to have_content("Airline: United")
      expect(page).to have_content("Passenger Name: Rodrigo")

      # And next to each flight number I see the name of the Airline of that flight
      expect(page).to have_content("Flight Number: 5678")
      expect(page).to have_content("Passenger Name: Ezequiel")
      expect(page).to have_content("Airline: United")

      # And under each flight number I see the names of all that flight's passengers

    end
  end
end