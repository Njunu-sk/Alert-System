class AlertsController < ApplicationController
  def create
    alert = Alert.new(alert_params)

    if alert.type.in?(%w[portal_opened portal_closed])
      if alert.save
        render json: alert, status: :created
      else
        render json: alert.errors, status: :unprocessable_entity
      end
    else
      render json: { error: "Invalid alert type" }, status: :unprocessable_entity
    end
  end

  private 

  def alert_params
    params.require(:alert).permit(:type, :title, :description, :origin, tags: [])
  end
end