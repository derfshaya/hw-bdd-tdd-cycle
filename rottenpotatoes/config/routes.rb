Rottenpotatoes::Application.routes.draw do
  resources :movies do
    member do
      get 'search_by_director', as: :search_by_directors
    end
  end
  # map '/' to be a redirect to '/movies'
  root controller: :movies, action: :index
end
