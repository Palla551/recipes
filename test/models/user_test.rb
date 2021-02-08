require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "User", email: "email@email.com", password: "1234")
  end

  test "User name should be valid" do
    assert @user.valid?
  end

  test "User name can not be empty" do
    @user.name = ""
    assert_not @user.valid?
  end

  test "User email can not be empty" do
    @user.email = ""
    assert_not @user.valid?
  end

  test "User name should be less than 20" do
    @user.name = "a" * 21
    assert_not @user.valid?
  end

  test "Should be an email" do
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
    assert @user.email =~VALID_EMAIL_REGEX
  end

  test "Email should be unique" do
    duplicate = @user.dup
    duplicate.email = @user.email.upcase
    @user.save
    assert_not duplicate.valid?
  end

end
