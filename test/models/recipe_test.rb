require 'test_helper'

class RecipeTest < ActiveSupport::TestCase

  def setup
    @user = User.create!(name: "nombre", email: "email@test.com", password: "1234")
    @recipe = @user.recipes.build(name: "Vegetable", description: "A nutritive cucumber")
  end

  test "recipe name should be valid" do
    assert @recipe.valid?
  end

  test "recipe name can not be empty" do
    @recipe.name = ""
    assert_not @recipe.valid?
  end

  test "recipe description can not be empty" do
    @recipe.description = ""
    assert_not @recipe.valid?
  end

end
