# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app
  - config/environment.rb specifies Sinatra as the environment
- [x] Use ActiveRecord for storing information in a database
  - config/environment.rb establishes ActiveRecord connection and migrations specify use of ActiveRecord
- [x] Include more than one model class (list of model class names e.g. User, Post, Category)
  - User model class and Recipe model class included.
- [x] Include at least one has_many relationship on your User model (x has_many y, e.g. User has_many Posts)
  - User has_many Recipes
- [x] Include at least one belongs_to relationship on another model (x belongs_to y, e.g. Post belongs_to User)
  - Recipe belongs_to User
- [x] Include user accounts
  - User accounts are created via /signup route, which directs to signup form (views/users/create_user.rb)
- [x] Ensure that users can't modify content created by other users
  - Users only see the edit and delete buttons if it is their own recipe (this is checked by matching current_user helper method to recipe.user)
  - Users are also rerouted to the login page if they attempt to go to the edit page and are not the recipe.user.
- [x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying
  - Recipe is created via the '/recipes/new' route which displays the form found in views/recipes/create_recipe.erb
  - Recipe is read via the '/recipes/:id' route which displays views/recipes/show.erb
  - Recipe is updated via the '/recipes/:id/edit' route which displays the form found in views/recipes/edit.erb
  - Recipe is deleted via the delete button/form found on the recipe's show page.
- [x] Include user input validations
  - Validations included in the User and Recipe models.
- [x] Display validation failures to user with error message (example form URL e.g. /posts/new)
  - Error messages appear based on validation failure with the use of flash[:message].
- [x] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code
  - README.md includes short description, install instructions, contributors guide, and link to license.

Confirm
- [x] You have a large number of small Git commits
- [x] Your commit messages are meaningful
- [x] You made the changes in a commit that relate to the commit message
- [x] You don't include changes in a commit that aren't related to the commit message
