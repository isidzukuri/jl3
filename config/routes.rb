Rails.application.routes.draw do
  root 'home#index'

  resources :blog, only: [:index, :show]
  get 'blog/page/:page', to: 'blog#index'

end
