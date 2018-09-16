require 'rack-flash'

class RecipesController < ApplicationController
  use Rack::Flash
  
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
    if !@recipe.save
      flash[:message] = "Oops, something went wrong. Please make sure all required fields are filled out."
      redirect "/recipes/new"
    else
      @recipe.save
      redirect "/recipes/#{@recipe.id}"
    end
  end

  get '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    if logged_in?
      @user = @recipe.user
      erb :'/recipes/show'
    else
      redirect "/login"
    end
  end

  get '/recipes/:id/edit' do
    @recipe = Recipe.find_by_id(params[:id])
    if logged_in? && current_user == @recipe.user
      erb :'/recipes/edit'
    else
      redirect "/login"
    end
  end

  patch '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    if !@recipe.update(:name => params[:name], :description => params[:description], :serving_size => params[:serving_size], :prep_time => params[:prep_time], :cook_time => params[:cook_time], :ingredients => params[:ingredients], :instructions => params[:instructions])
      flash[:message] = "Oops, something went wrong. Please make sure all required fields are filled out."
      redirect "/recipes/new"
    else
      @recipe.update(:name => params[:name], :description => params[:description], :serving_size => params[:serving_size], :prep_time => params[:prep_time], :cook_time => params[:cook_time], :ingredients => params[:ingredients], :instructions => params[:instructions])
      redirect "/recipes/#{@recipe.id}"
    end
  end

  delete '/recipes/:id/delete' do
    @recipe = Recipe.find_by_id(params[:id])
    if logged_in? && current_user == @recipe.user
      @recipe.delete
    end
    redirect "/recipes"
  end

end
