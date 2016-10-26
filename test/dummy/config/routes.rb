Rails.application.routes.draw do

  resources :books
  mount Librails::Engine => "/librails"
end
