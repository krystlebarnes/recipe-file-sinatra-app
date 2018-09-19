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
    user = User.new(name: params[:name], email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])
    if user.save
      user.save
      session[:user_id] = user.id
      redirect "/recipes"
    else
      case
      when params[:name].empty?
        flash[:message] = "Oops, we need to know your name."
        redirect "/signup"
      when params[:email].match(/\A[^@]+@([^@\.]+\.)+[^@\.]+\z/) == nil
        flash[:message] = "Oops, we need to know your email."
        redirect "/signup"
      when User.find_by(email: params[:email])
        flash[:message] = "Oops, there's already an account with that email."
        redirect "/signup"
      when params[:password].empty?
        flash[:message] = "Oops, you need a password."
        redirect "/signup"
      when params[:password].size < 8
        flash[:message] = "Oops, your password needs to be at least 8 characters long."
        redirect "/signup"
      when params[:password] != params[:password_confirmation]
        flash[:message] = "Oops, your passwords didn't match."
        redirect "/signup"
      else
        flash[:message] = "Oops, something went wrong. Let's try that again."
        redirect "/signup"
      end
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
    elsif !user
      flash[:message] = "Oops, we couldn't find an account with that email."
      redirect "/login"
    elsif !user.authenticate(params[:password])
      flash[:message] = "Oops, that password is incorrect."
      redirect "/login"
    else
      flash[:message] = "Oops, something went wrong. Let's try that again."
      redirect "/login"
    end
  end

  get "/logout" do
    session.clear
    redirect "/"
  end

end
