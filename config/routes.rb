Rails.application.routes.draw do
  
  #resources :urls

  root to: 'urls#index'
  
  get "shortened", to: "urls#shortened", as: :shortened
  get "error", to: "urls#error", as: :error
  get "top", to: "urls#top"#, as: :top
  
  #get "/urls/create", to: "urls#create"
  post "/urls/create", to: "urls#create"
  
  get "/:short_url", to: "urls#show"
  #post "/:short_url", to: "urls#show"

end
