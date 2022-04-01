Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'meety#start'
  get 'start', to: 'meety#start'
  get 'suggestions', to: 'meety#suggestions'
  post 'people', to: 'meety#people'
end
