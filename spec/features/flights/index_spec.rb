require 'rails_helper'

RSpec.describe "Flights Index Page" do
  before(:each) do
    @airline1 = Airline.create!(name: "Southwest")
    @flight1 = Flight.create!(number: "1738", date: "08/03/19", departure_city: "Denver", arrival_city: "Reno", airline_id: @airline1.id)
    @flight2 = Flight.create!(number: "1314", date: "09/13/20", departure_city: "Atlanta", arrival_city: "NYC", airline_id: @airline1.id)
    @flight3 = Flight.create!(number: "1690", date: "03/03/21", departure_city: "LA", arrival_city: "LV", airline_id: @airline1.id)
    @passenger1 = @flight1.passengers.create!(name: "Joe", age: 7)
    @passenger2 = @flight1.passengers.create!(name: "Happy", age: 8)
    @passenger3 = @flight2.passengers.create!(name: "Luis", age: 17)
    @passenger4 = @flight3.passengers.create!(name: "Cam", age: 74)
    @passenger5 = @flight3.passengers.create!(name: "Baby", age: 35)
    @flight2.passengers << [@passenger2]
  end

  describe 'User Story 1' do
    it "displays all flight numbers" do
      visit flights_path

      expect(page).to have_content("Flight Number: 1738")
      expect(page).to have_content("Flight Number: 1314")
      expect(page).to have_content("Flight Number: 1690")
    end

    it "displays airline of each flight" do
      visit flights_path

      within "#flights-#{@flight1.id}" do
        expect(page).to have_content("Southwest") 
      end

      within "#flights-#{@flight2.id}" do
        expect(page).to have_content("Southwest") 
      end

      within "#flights-#{@flight3.id}" do
        expect(page).to have_content("Southwest") 
      end
    end

    it "displays each flight's passengers" do
      visit flights_path

      within "#flights-#{@flight1.id}" do
        expect(page).to have_content("Joe")
        expect(page).to have_content("Happy")
        expect(page).to_not have_content("Luis")
      end

      within "#flights-#{@flight2.id}" do
        expect(page).to have_content("Luis")
        expect(page).to have_content("Happy")
        expect(page).to_not have_content("Cam")
      end

      within "#flights-#{@flight3.id}" do
        expect(page).to have_content("Cam")
        expect(page).to have_content("Baby")
        expect(page).to_not have_content("Luis")
      end
    end
  end

  describe 'User Story 2' do
    it "has a button to remove passenger" do
      visit flights_path

      within "#flights-#{@flight1.id}" do
        expect(page).to have_button("Joe")
        expect(page).to have_button("Happy")
        expect(page).to_not have_button("Luis")

        expect(page).to have_button("Remove Happy")
        click_on "Remove Happy"
        expect(current_path).to eq(flights_path)

        expect(page).to_not have_content("Happy")
        expect(page).to_not have_button("Happy")
      end     
      
      within "#flights-#{@flight2.id}" do
        expect(page).to have_content("Luis")
        expect(page).to have_content("Happy")
      end
    end
  end
end