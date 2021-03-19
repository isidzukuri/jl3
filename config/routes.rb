Rails.application.routes.draw do
  root 'home#index'

  resources :blog, only: [:index, :show]
  get 'blog/page/:page', to: 'blog#index'

  scope '(java-book)' do
    get 'fsymbol/:id(/page/:page)', to: 'first_letters#show'
    get 'genre/:id(/page/:page)', to: 'genres#show'
    resources :author, only: [:index, :show]
    resources :book, only: [:show]
  end
end
