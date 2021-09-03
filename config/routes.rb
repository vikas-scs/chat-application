Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :admins
  mount ActionCable.server => '/cable'
  resources :conversations, only: [:create] do
    member do
      post :close
    end
    resources :messages, only: [:create]
  end
  devise_for :users,controllers: {registrations: "user/registrations", confirmations: "user/confirmations", sessions: "user/sessions"}
  root to: "home#index"
  get "home/send_request", to: "home#send_request", as: :send_request
  get "home/my_requests", to: "home#my_requests", as: :my_requests
  get "home/respond_request", to: "home#respond_request", as: :respond_request
  get "home/my_friends", to: "home#my_friends", as: :my_friends
  get "home/add_friends", to: "home#add_friends", as: :add_friends
  get "post/add_post", to: "post#add_post", as: :add_post
  get "post/show_post", to: "post#show_post", as: :show_post
  get "post/commet", to: "post#commet", as: :commet
  get "room/new", to: "room#new", as: :room
  get "room/save_message", to: "room#save_message", as: :save_message
  post "message/create", to: "message#create"
  get "home/unfriend", to: "home#unfriend", as: :unfriend
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
