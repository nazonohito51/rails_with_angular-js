Rails.application.routes.draw do
  #resources :items
  #root "items#index"
  root "templates#index"

  namespace :api do
    resources :items
    resources :purchase_headers
  end

  get "/dashboard" => "templates#index"
  get "/templates/:path.html" => "templates#template", constraints: { path: /.+/ }

  get   "/*path"  => "templates#index"
end
