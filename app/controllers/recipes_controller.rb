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
    @recipe = Recipe.new(:name => params[:name], :description => params[:description], :serving_size => params[:serving_size], :prep_time => params[:prep_time], :cook_time => params[:cook_time], :ingredients => params[:ingredients], :instructions => params[:instructions])
    @recipe.user_id = current_user.id
    @recipe.save
    redirect "/recipes/#{@recipe.slug}"
  end

  get '/recipes/:slug' do
    @recipe = Recipe.find_by_slug(params[:slug])
    if logged_in?
      @user = @recipe.user
      erb :'/recipes/show'
    else
      redirect "/login"
    end
  end

end
