require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user =User.new(name: "prenom1 Nom1" ,email: "prenom1@example.com", password: "password", password_confirmation: "password")
  end


  test "nom doit etre present" do
    @user.name=""
    assert_not @user.valid?
  end

  test "email doit etre present" do
    @user.email=""
    assert_not @user.valid?
  end
  test "nom ne doit pas etre trop long" do
    @user.name="a"*51
    assert_not @user.valid?
  end

  test "email ne doit pas etre trop long" do
    @user.email="a"*244+"@example.com"
    assert_not @user.valid?
  end
  test "email validation doit accepter les adresses valides" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |address|
      @user.email = address
      assert @user.valid?, "#{address.inspect} devrait être valide"
    end
  end

  test "email doit etre unique" do
    @user.save
    dup_user = @user.dup
    dup_user.email = @user.email.upcase
    dup_user.save
    assert_not dup_user.valid?
  end

  test "password doit etre present" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password doit etre de long" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
end
