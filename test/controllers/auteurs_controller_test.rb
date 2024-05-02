require "test_helper"

class AuteursControllerTest < ActionDispatch::IntegrationTest
  setup do
    @auteur = auteurs(:one)
  end

  test "should get index" do
    get auteurs_url
    assert_response :success
  end

  test "should get new" do
    get new_auteur_url
    assert_response :success
  end

  test "should create auteur" do
    assert_difference("Auteur.count") do
      post auteurs_url, params: { auteur: { nom_prenom: @auteur.nom_prenom } }
    end

    assert_redirected_to auteur_url(Auteur.last)
  end

  test "should show auteur" do
    get auteur_url(@auteur)
    assert_response :success
  end

  test "should get edit" do
    get edit_auteur_url(@auteur)
    assert_response :success
  end

  test "should update auteur" do
    patch auteur_url(@auteur), params: { auteur: { nom_prenom: @auteur.nom_prenom } }
    assert_redirected_to auteur_url(@auteur)
  end

  test "should destroy auteur" do
    assert_difference("Auteur.count", -1) do
      delete auteur_url(@auteur)
    end

    assert_redirected_to auteurs_url
  end
end
