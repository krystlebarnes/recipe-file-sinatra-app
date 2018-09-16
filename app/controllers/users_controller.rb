require 'rack-flash'

class UsersController < ApplicationController
  use Rack::Flash

  get "/signup" do
    if !logged_in?
      erb :'/users/create_user'
    else
      redirect "/recipes"
    end
  end

  post "/signup" do
    user = User.new(name: params[:email], email: params[:email], password: params[:password])
    if !user.save
      flash[:message] = "Oops, something went wrong. Please make sure all fields are filled out and the password is at least 8 characters long."
      redirect "/signup"
    else
      user.save
      session[:user_id] = user.id
      redirect "/recipes"
    end
  end

  get "/users/:slug" do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end

  get "/login" do
    if logged_in?
      redirect "/recipes"
    else
      erb :'/users/login'
    end
  end

  post "/login" do
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/recipes"
    else
      flash[:message] = "Oops, something went wrong. Let's try that again."
      redirect "/login"
    end
  end

  get "/logout" do
    session.clear
    redirect "/login"
  end

end
