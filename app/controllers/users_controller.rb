class UsersController < ApplicationController

  get "/signup" do
    if !logged_in?
      erb :'/users/create_user'
    else
      redirect "/recipes"
    end
  end

  post "/signup" do
    user = User.new(email: params[:email], password: params[:password])
    user.save
    session[:user_id] = user.id
    redirect to "/recipes"
  end

  get "/users/:slug" do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end

end
