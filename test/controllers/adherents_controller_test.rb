require "test_helper"

class AdherentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @adherent = adherents(:one)
  end

  test "should get index" do
    get adherents_url
    assert_response :success
  end

  test "should get new" do
    get new_adherent_url
    assert_response :success
  end

  test "should create adherent" do
    assert_difference("Adherent.count") do
      post adherents_url, params: { adherent: { id: @adherent.id, nom: @adherent.nom, prenom: @adherent.prenom } }
    end

    assert_redirected_to adherent_url(Adherent.last)
  end

  test "should show adherent" do
    get adherent_url(@adherent)
    assert_response :success
  end

  test "should get edit" do
    get edit_adherent_url(@adherent)
    assert_response :success
  end

  test "should update adherent" do
    patch adherent_url(@adherent), params: { adherent: { id: @adherent.id, nom: @adherent.nom, prenom: @adherent.prenom } }
    assert_redirected_to adherent_url(@adherent)
  end

  test "should destroy adherent" do
    assert_difference("Adherent.count", -1) do
      delete adherent_url(@adherent)
    end

    assert_redirected_to adherents_url
  end
end
