Application.setup_router do
  get '/', to: 'home#index', as: :root

  resource :account, only: [:new, :create] do
    member do
      get  :membership
      post :join
    end
  end
  resources :rooms
  resources :teams
end
