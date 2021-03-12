class ReservationsController < ApplicationController
  protect_from_forgery with: :null_session

  def index
    @reservations = Reservation.recent
  end

  def create
    @reservation = Reservation.booking(**reservation_param)

    respond_to do |format|
      format.json do
        if @reservation.save
          render json: @reservation, status: :created
        else
          render json: @reservation.errors, status: :unprocessable_entity
        end
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
