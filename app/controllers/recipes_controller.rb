class RecipesController < ApplicationController

  get '/recipes' do
    if logged_in?
      @user = current_user
      erb :'/recipes/recipes'
    else
      redirect "/login"
    end
  end

  get '/recipes/new' do
    if logged_in?
      erb :'/recipes/create_recipe'
    else
      redirect "/login"
    end
  end

  post '/recipes' do
    @recipe = Recipe.new(:name => params[:name], :description => params[:description], :serving_size => params[:serving_size], :prep_time => params[:prep_time], :cook_time => params[:cook_time], :ingredients , :name => params[:name]=> params[:ingredients], :instructions => params[:instructions])
    @recipe.user_id = current_user.id
    @recipe.save
    redirect "/recipes/#{@recipe.slug}"
  end

end
