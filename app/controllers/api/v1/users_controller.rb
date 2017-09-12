class Api::V1::UsersController < ApplicationController
	before_action :authorized, only: [:show]

  def create
    @user = User.new(username: params[:username], password:params[:password], email:params[:email])
    if @user.save
      payload = {user_id: @user.id}

      render json: {user: @user, jwt: issue_token(payload), success: "Welcome #{@user.username} to Movie Recommender!"}
    else
      byebug
      render json: @user.errors.messages
    end
  end

  def my_movies
      render json: {movies: current_user.movies, user: current_user}
  end

  def add_movie
     user = current_user
     movie = Movie.find_by(id: params[:movie])
    
     responseObj = {user: user, 
                    movies: user.movies}


    if user.movies.include?(movie)
      responseObj[:message] = "'#{movie.title}' is already in your list!"
    else
       user.movies << movie
      if user.save
        responseObj[:message] = "'#{movie.title}' successfully saved to your account!"
      else
        responseObj[:message] = "Oops! Something went wrong! '#{movie.title}' was not saved to your account!"
      end
    end

    render json: responseObj

  end

  def show

    render json: {user: current_user, movies: current_user.movies}
  end


end