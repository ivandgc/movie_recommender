Rails.application.routes.draw do
  namespace :api do
  	namespace :v1 do
  		resources :movies, only: [:index]
  		resources :users, only: [:create, :show]
  		resources :watched_movies, only: [:create, :show, :destroy]
  		get '/my_movies', to: 'users#my_movies'
  		post '/add_movie', to: 'users#add_movie'
  		post '/login', to: 'auth#create'
  	end
  end

end
