class ReservationsController < ApplicationController
  protect_from_forgery with: :null_session

  def index
    @reservations = Reservation.all
  end

  def create
    @reservation = Reservation.booking(**reservation_param)

    respond_to do |format|
      if @reservation.save
        format.html { render :index, notice: 'Reservation was successfully created.' }
        format.json { render json: @reservation, status: :created }
      else
        format.html { render :index }
        format.json { render json: @reservation.errors, status: :unprocessable_entity}
      end
    end
  end

  private

    include ReservationServicePayload

    def reservation_param
      if params.has_key? :guest
        Format2.parse params
      else
        Format1.parse params.fetch(:reservation, {})
      end
    end
end
