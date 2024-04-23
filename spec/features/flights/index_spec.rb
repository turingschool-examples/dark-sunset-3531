require "rails_helper"

RSpec.describe "Flights Index Page" do
  before(:each) do
    @ar1 = Airline.create!(name: "United")

    @f1 = @ar1.flights.create!(number: "1234", date:"01/02/03", departure_city: "Denver", arrival_city: "PVR")
    @f2 = @ar1.flights.create!(number: "4321", date:"01/22/33", departure_city: "Cali", arrival_city: "KC")
    @f3 = @ar1.flights.create!(number: "5678", date:"01/23/33", departure_city: "Utah", arrival_city: "Denver")
    # @f4 = @ar1.flights.create!(number: "5678", date:"01/23/33", departure_city: "LA", arrival_city: "ZAC")

    @p1 = Passenger.create!(name:"Martin", age: 21, flights_id: @f1.id)
    @p2 = Passenger.create!(name:"Rodrigo", age: 19, flights_id: @f1.id)
    @p3 = Passenger.create!(name:"Ezequiel", age: 18, flights_id: @f1.id)
    @p4 = Passenger.create!(name:"bob", age: 13, flights_id: @f1.id)
    

    @f1.passengers << [@p1, @p4]
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
      # And under each flight number I see the names of all that flight's passengers

      expect(page).to have_content("Flight Number: 4321")
      expect(page).to have_content("Airline: United")
      expect(page).to have_content("Passenger Name: Rodrigo")

      # And next to each flight number I see the name of the Airline of that flight
      expect(page).to have_content("Flight Number: 5678")
      expect(page).to have_content("Passenger Name: Ezequiel")
      expect(page).to have_content("Airline: United")

    end
  end

  describe '#us 2' do
    it 'remove passanger from flight ' do
      # When I visit the flights index page
      visit flights_path
      # Next to each passengers name
      
      expect(page).to have_content("Passenger Name: bob")
      # I see a link or button to remove that passenger from that flight
      expect(page).to have_button("Remove #{@p4.name}")
      # When I click on that link/button
      click_on("Remove #{@p4.name}")
      
      
      # I'm returned to the flights index page
      expect(current_path).to eq(flights_path)
      # And I no longer see that passenger listed under that flight,
      expect(page).to have_content("Passenger Name: Martin")
      expect(page).to_not have_content("Passenger Name: bob")
      # And I still see the passenger listed under the other flights they were assigned to.

    end
  end
end