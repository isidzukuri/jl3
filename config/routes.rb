Rails.application.routes.draw do
  root 'home#index'

  scope '(java-book)' do
    get 'book/:id', to: 'books#show', as: :book
    get 'author/bio/:id', to: 'authors#bio' , as: :author_bio
    get 'author/:id', to: 'authors#show' , as: :author
    get 'genre/:id(/page/:page)', to: 'genres#show'
    get 'fsymbol/:id(/page/:page)', to: 'first_letters#show'
  end

  resources :blog, only: [:index, :show]
  get 'blog/page/:page', to: 'blog#index'
  get 'latest', to: 'books#latest'
  get 'tag/list', to: 'tags#index'
  get 'tag/:id(/page/:page)', to: 'tags#show'
end
