class AirlinesController < ApplicationController

  def show 
    @airline = Airline.find(params[:id])
    @passengers = @airline.older_passengers
  end
end