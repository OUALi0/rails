require "test_helper"

class MaterielsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @materiel = materiels(:one)
  end

  test "should get index" do
    get materiels_url
    assert_response :success
  end

  test "should get new" do
    get new_materiel_url
    assert_response :success
  end

  test "should create materiel" do
    assert_difference("Materiel.count") do
      post materiels_url, params: { materiel: { mat_type: @materiel.mat_type, nom: @materiel.nom } }
    end

    assert_redirected_to materiel_url(Materiel.last)
  end

  test "should show materiel" do
    get materiel_url(@materiel)
    assert_response :success
  end

  test "should get edit" do
    get edit_materiel_url(@materiel)
    assert_response :success
  end

  test "should update materiel" do
    patch materiel_url(@materiel), params: { materiel: { mat_type: @materiel.mat_type, nom: @materiel.nom } }
    assert_redirected_to materiel_url(@materiel)
  end

  test "should destroy materiel" do
    assert_difference("Materiel.count", -1) do
      delete materiel_url(@materiel)
    end

    assert_redirected_to materiels_url
  end
end
