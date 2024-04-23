class PassengerFlightsController < ApplicationController

  def destroy 
    # require 'pry'; binding.pry
    PassengerFlight.find_by(passenger_id: params[:passenger_id], flight_id: params[:flight_id]).destroy
    redirect_to flights_path
  end
end