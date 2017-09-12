class Api::V1::UsersController < ApplicationController
	before_action :authorized, only: [:show]

  def create
    @user = User.new(username: params[:username], password:params[:password], email:params[:email])
    if @user.save
      payload = {user_id: @user.id}

      render json: {user: @user, jwt: issue_token(payload)}
    else
      ## send some error message
    end
  end

  def my_movies
      render json: current_user.movies
  end

  def add_movie
     user = current_user
     
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

  def show

    render json: current_user
  end


end