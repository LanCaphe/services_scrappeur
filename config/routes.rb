Rails.application.routes.draw do
  resources :cryptos

  root 'pages#punition'
  get 'home' => 'pages#home'
  post 'home' => 'pages#create'

end
