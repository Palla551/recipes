require "test_helper"

class RecipesEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create!(name: "nombre", email: "email@test.com", password: "1234")
    @recipe = @user.recipes.create(name: "Vegetable", description: "A nutritive cucumber")
  end

  test "reject invalid update" do
    get edit_recipe_path(@recipe)
    assert_template "recipes/edit"
    patch recipe_path(@recipe), params: {recipe: {name: "", description: "Description"}}
    assert_template "recipes/edit"

  end

  test "accepct correct update" do
    get edit_recipe_path(@recipe)
    assert_template "recipes/edit"

    update_recipe_name = "new name"
    update_recipe_description = "new description"

    patch recipe_path(@recipe, params: {recipe: {name: update_recipe_name, description: update_recipe_description } })
    follow_redirect!

    @recipe.reload
    assert_match update_recipe_name, @recipe.name
    assert_match update_recipe_description, @recipe.description 

  end
end
