Rails.application.routes.draw do
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  resources :users do
    resources :listings
  end

  resources :bookings
  resources :tags

  get 'user#url_after_create' => "listings#index"
  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "users#new", as: "sign_up"

  post '/listing/:listing_id/booking' => 'bookings#create', as: "create_booking"

  get "extra_tag/:listing_id" => 'tags#index', as: "extra_tag"
  delete "listing/:id/extra_tag/:tag_id" => 'tags#destroy', as: "delete_extra_tag"
  get "extra_tag/:tag_id/edit" => 'tags#edit', as: "edit_extra_tag"

  post "users/moderate" => 'users#moderator', as: "become_moderator"
  post "listing/:listing_id/verify" => 'listings#verify', as: "listing_verify"

  root "listings#index"
end
