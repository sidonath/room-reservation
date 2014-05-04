Application.setup_router do
  get '/', to: 'home#index', as: :root

  resource :account, only: [:new, :create]
  resources :rooms
  resources :teams
end
