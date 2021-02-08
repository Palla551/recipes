require "test_helper"

class RecipeIntegrationTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create!(name: "nombre", email: "email@test.com", password: "1234")
    @recipe = @user.recipes.create(name: "Vegetable", description: "A nutritive cucumber")
  end

  test "Should exist" do
     get recipes_url
     assert_response :success
   end

   test "should get recipes show" do
     get recipes_path
     assert_template 'recipes/index'
     assert_select "a[href=?]", recipe_path(@recipe), text: @recipe.name
     #assert_select "a[href=?]", recipe_path(@recipe), text: "Delete"
   end

   test "create new recipe" do
     get new_recipe_path
     assert_response :success

     name_of_recipe = "Vegetable"
     description_of_recipe = "Description of Vegetable"

     assert_difference "Recipe.count", 1 do
       post recipes_path, params: { recipe: { name: name_of_recipe, description: description_of_recipe } }
     end
     follow_redirect!

   end

   test "reject invalid recipe" do
     get new_recipe_path
     assert_response :success

     assert_no_difference "Recipe.count" do
       post recipes_path, params: { recipe: { name:" ", description:" " } }
     end
     assert_template "recipes/new"
   end
end
