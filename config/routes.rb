Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'forecast', to: 'weather#forecast'
      get 'munchies', to: 'travel#munchies'
    end
  end
end
