module Api
  module V1
    class PollingController < ApplicationController
      before_action :set_alert, only: [:check_spread]

      # GET /api/v1/polling/:id
      def check_spread
        if @alert.nil?
          render json: { error: 'Alert not found' }, status: :not_found
          return
        end

        spread_comparison = obtener_spread_comparison(@alert.id)
        if spread_comparison.nil?
          render json: { error: 'No se pudo obtener el spread actual del mercado.' }, status: :unprocessable_entity
        else
          render json: { message: spread_comparison }, status: :ok
        end
      end

      private

      def set_alert
        @alert = Alert.find_by(id: params[:id])
      end

      def obtener_spread_comparison(alerta_id)
        alerta = Alert.find(alerta_id)
        market_id = alerta.market_id
        spread_actual = obtener_spread(market_id)
        compare_spreads(spread_actual, alerta.spread)
      end

      def obtener_spread(market_id)
        response = RestClient.get("https://www.buda.com/api/v2/markets/#{market_id}/ticker")
        ticker_data = JSON.parse(response.body)['ticker']
        
        max_bid = ticker_data['max_bid'][0].to_f
        min_ask = ticker_data['min_ask'][0].to_f
        
        spread = min_ask - max_bid
        
        return spread
      end

      def compare_spreads(actual_spread, target_spread)
        return nil if actual_spread.nil?

        if actual_spread > target_spread
          'El spread actual es mayor que el spread guardado en la alerta.'
        elsif actual_spread < target_spread
          'El spread actual es menor que el spread guardado en la alerta.'
        else
          'El spread actual es igual al spread guardado en la alerta.'
        end
      end

      def handle_error(exception)
        render json: { error: 'Ocurrió un error al procesar la solicitud.' }, status: :internal_server_error
      end
    end
  end
end

