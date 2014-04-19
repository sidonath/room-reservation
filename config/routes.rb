Application.setup_router do
  get '/', to: 'home#index'

  resources :rooms
end
