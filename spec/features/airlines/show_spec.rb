require "rails_helper" 

RSpec.describe "Airline show page" do
  before(:each) do
    @ar1 = Airline.create!(name: "United")

    @f1 = @ar1.flights.create!(number: "1234", date:"01/02/03", departure_city: "Denver", arrival_city: "PVR")
    @f2 = @ar1.flights.create!(number: "4321", date:"01/22/33", departure_city: "Cali", arrival_city: "KC")
    @f3 = @ar1.flights.create!(number: "5678", date:"01/23/33", departure_city: "Utah", arrival_city: "Denver")

    @p1 = Passenger.create!(name:"Martin", age: 21, flights_id: @f1.id)
    @p2 = Passenger.create!(name:"Rodrigo", age: 19, flights_id: @f2.id)
    @p3 = Passenger.create!(name:"Ezequiel", age: 28, flights_id: @f3.id)
    @p4 = Passenger.create!(name:"bob", age: 8, flights_id: @f1.id)
    @p5 = Passenger.create!(name:"bill", age: 3, flights_id: @f1.id)
    

    @f1.passengers << [@p1, @p4]
    @f2.passengers << [@p2]
    @f3.passengers << [@p3, @p5]
  end

  describe '#us3' do
    it 'list passengers that are an adult, that are distinct as well' do
      # When I visit an airline's show page
      visit airline_path(@ar1.id)
      # Then I see a list of passengers that have flights on that airline
      # And I see that this list is unique (no duplicate passengers)
      expect(page).to have_content("Passenger Name: Martin")
      expect(page).to have_content("Passenger Name: Rodrigo")
      expect(page).to have_content("Passenger Name: Ezequiel")
      # And I see that this list only includes adult passengers.
      expect(page).to_not have_content("Passenger Name: bob")
      expect(page).to_not have_content("Passenger Name: billy")
      
      # (Note: an adult is anyone with age greater than or equal to 18)

    end
  end
end