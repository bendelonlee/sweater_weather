Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get "forecast", to: "forecasts#show"
      get "background", to: "background#show"
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
