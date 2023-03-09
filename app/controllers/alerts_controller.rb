class AlertsController < ApplicationController
  
  def index
    @alerts = Alert.all

    render json: { alerts: @alerts }
  end

  def show
    @alert = Alert.find(params[:id])

    render json: { alert: @alert }
  end

  def create
    alert = current_user.alerts.create!(alert_params)

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
