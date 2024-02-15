module Api
  module V1
    class AlertsController < ApplicationController
      before_action :set_alert, only: [:show, :update, :destroy]

      # POST /api/v1/alerts
      def create
        @alert = Alert.new(alert_params)
        @alert.market_id = params[:market_id]
        @alert.spread = params[:spread_value]

        if @alert.save
          render json: @alert, status: :created
        else
          handle_error(@alert.errors)
        end
      end

      # GET /api/v1/alerts/:id
      def show
        render json: @alert
      rescue ActiveRecord::RecordNotFound => e
        handle_error(e)
      end

      # PATCH/PUT /api/v1/alerts/:id
      def update
        if @alert.update(alert_params)
          render json: @alert
        else
          handle_error(@alert.errors)
        end
      rescue ActiveRecord::RecordNotFound => e
        handle_error(e)
      end

      # DELETE /api/v1/alerts/:id
      def destroy
        @alert.destroy
      rescue ActiveRecord::RecordNotFound => e
        handle_error(e)
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_alert
        @alert = Alert.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def alert_params
        params.require(:alert).permit(:market_id, :spread_value)
      end

      # Handle errors and render appropriate response
      def handle_error(error)
        render json: { error: error.message }, status: :unprocessable_entity
      end
    end
  end
end
