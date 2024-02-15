Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # Rutas para calcular el spread y obtener el spread de todos los mercados
      get 'markets/:market_id/spread', to: 'markets#calculate_spread'
      get 'markets/spread_all', to: 'markets#all_spreads'

      # Rutas para manejar las alertas de spread
      post '/alerts', to: 'alerts#create'
      get '/alerts/:id', to: 'alerts#show'
      put 'alerts/:id', to: 'alerts#update'
      delete 'alerts/:id', to: 'alerts#destroy'

      # Rutas para realizar el polling de alertas de spread
      get 'polling/:id', to: 'polling#check_spread'
    end
  end
end
