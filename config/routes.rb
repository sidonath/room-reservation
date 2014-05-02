Application.setup_router do
  get '/', to: 'home#index'

  resources :rooms
  resources :teams
end
