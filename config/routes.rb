Rails.application.routes.draw do
  root 'home#index'

  scope '(java-book)' do
    resources :book, only: [:show]
    resources :author, only: [:index, :show]
    get 'genre/:id(/page/:page)', to: 'genres#show'
    get 'fsymbol/:id(/page/:page)', to: 'first_letters#show'
  end

  resources :blog, only: [:index, :show]
  get 'blog/page/:page', to: 'blog#index'
  get 'latest', to: 'book#latest'
  get 'tag/list', to: 'tags#index'
  get 'tag/:id(/page/:page)', to: 'tags#show'
end
