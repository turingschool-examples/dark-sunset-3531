require 'rails_helper'

RSpec.describe "Flights Index Page" do
  before(:each) do
    @airline1 = Airline.create!(name: "Southwest")
    @flight1 = Flight.create!(number: "1738", date: "08/03/19", departure_city: "Denver", arrival_city: "Reno", airline_id: @airline1.id)
    @flight2 = Flight.create!(number: "1314", date: "09/13/20", departure_city: "Atlanta", arrival_city: "NYC", airline_id: @airline1.id)
    @flight3 = Flight.create!(number: "1690", date: "03/03/21", departure_city: "LA", arrival_city: "LV", airline_id: @airline1.id)
    @passenger1 = @flight1.passengers.create!(name: "Joe", age: 7)
    @passenger2 = @flight1.passengers.create!(name: "Happy", age: 8)
    @passenger3 = @flight2.passengers.create!(name: "Luis", age: 18)
    @passenger4 = @flight3.passengers.create!(name: "Cam", age: 74)
    @passenger5 = @flight3.passengers.create!(name: "Baby", age: 35)
    @flight2.passengers << [@passenger2, @passenger4, @passenger5]
  end

  describe 'User Story 3' do
    it "displays all unique passengers on a airline" do
      visit airline_path(@airline1)
   
      expect(page).to have_content("Luis", count: 1)
      expect(page).to have_content("Cam", count: 1 )
      expect(page).to have_content("Baby", count: 1)
    end
  end
end