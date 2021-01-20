Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'forecast', to: 'weather#forecast'
      get 'backgrounds', to: 'images#background'
      post 'users', to: 'users#create'
      post 'sessions', to: 'sessions#create'
      post 'road_trip', to: 'road_trip#create'
    end
  end
end
