require "test_helper"

class RecipesDeleteTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create!(name: "nombre", email: "email@test.com", password: "1234")
    @recipe = @user.recipes.create(name: "Vegetable", description: "A nutritive cucumber")
  end

  test "Success to delete recipe" do
    get recipe_path(@recipe)
    assert_template "recipes/show"
    assert_difference "Recipe.count", -1 do
      delete recipe_path(@recipe)
    end
    follow_redirect!
  end
end
