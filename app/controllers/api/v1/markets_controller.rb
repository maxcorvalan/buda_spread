module Api
  module V1
    class MarketsController < ApplicationController
      before_action :set_market, only: [:calculate_spread]

      # GET /api/v1/markets/:market_id/spread
      def calculate_spread
        market_id = params[:market_id]
        ticker = get_ticker(market_id)
        order_book = get_order_book(market_id)
      
        if ticker && order_book
          best_bid = order_book['bids'].first&.first.to_f
          best_ask = order_book['asks'].first&.first.to_f
          spread = best_ask - best_bid
          render json: { market_id: market_id, spread: spread }, status: :ok
        else
          handle_error('Unable to fetch data for the market')
          return # Agregar un return para salir de la acción después de llamar a render
        end
      end

      # GET /api/v1/markets/spread_all
      def all_spreads
        markets = get_all_markets
        spreads = []

        markets.each do |market|
          ticker = get_ticker(market['id'])
          order_book = get_order_book(market['id'])

          if ticker && order_book
            best_bid = order_book['bids'].first&.first.to_f
            best_ask = order_book['asks'].first&.first.to_f
            spread = best_ask - best_bid
            spreads << { market_id: market['id'], spread: spread }
          end
        end
        render json: spreads, status: :ok
      end

      private

      def get_all_markets
        response = RestClient.get("https://www.buda.com/api/v2/markets")
        JSON.parse(response.body)['markets']
      rescue RestClient::ExceptionWithResponse => e
        handle_error(e)
        []
      end

      def set_market
        @market = params[:market_id]
      end

      def get_ticker(market_id)
        response = RestClient.get("https://www.buda.com/api/v2/markets/#{market_id}/ticker")
        JSON.parse(response.body)['ticker']
      end

      def get_order_book(market_id)
        response = RestClient.get("https://www.buda.com/api/v2/markets/#{market_id}/order_book")
        JSON.parse(response.body)['order_book']
      end

      def handle_error(exception)
        if exception.is_a?(RestClient::NotFound)
          render json: { error: 'Resource not found on the server' }, status: :not_found
        else
          render json: { error: exception.message }, status: :internal_server_error
        end
      end
      
    end
  end
end
