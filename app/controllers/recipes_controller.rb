class RecipesController < ApplicationController

  get '/recipes' do
    if logged_in?
      @user = current_user
      erb :'/recipes/recipes'
    else
      redirect "/login"
    end
  end

end
