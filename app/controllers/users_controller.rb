class UsersController < ApplicationController

  get "/signup" do
    if !logged_in?
      erb :'/users/create_user'
    else
      redirect "/recipes"
    end
  end

  post "/signup" do
    user = User.new(name: params[:email], email: params[:email], password: params[:password])
    user.save
    session[:user_id] = user.id
    redirect to "/recipes"
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
      redirect "/login"
    end
  end

  get "/logout" do
    session.clear
    redirect "/login"
  end

end
