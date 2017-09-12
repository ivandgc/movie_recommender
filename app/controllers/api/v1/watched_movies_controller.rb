class Api::V1::WatchedMoviesController < ApplicationController
	# before_action :authorized, only: [:show]

  def create

    user = User.find_by(id: params[:user])
    movie = Movie.find_by(id: params[:movie])
    watched_movie = WatchedMovie.new(user: user, movie: movie)


    if watched_movie.valid?
      user.movies << movie
      user.save
      render json: {user: user}
    else
      render json: {message: "Movie not Saved"}
    end
  end

  def destroy
    user = current_user
    movie = Movie.find_by(id: params[:movie])

    watched_movie = WatchedMovie.find_by(user: user, movie: movie)

    watched_movie.destroy

    render json: {user: user, movies: user.movies, message: "'#{movie.title}' was removed from your account!"}
  end

end