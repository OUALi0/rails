require "application_system_test_case"

class AuteursTest < ApplicationSystemTestCase
  setup do
    @auteur = auteurs(:one)
  end

  test "visiting the index" do
    visit auteurs_url
    assert_selector "h1", text: "Auteurs"
  end

  test "should create auteur" do
    visit auteurs_url
    click_on "New auteur"

    fill_in "Nom prenom", with: @auteur.nom_prenom
    click_on "Create Auteur"

    assert_text "Auteur was successfully created"
    click_on "Back"
  end

  test "should update Auteur" do
    visit auteur_url(@auteur)
    click_on "Edit this auteur", match: :first

    fill_in "Nom prenom", with: @auteur.nom_prenom
    click_on "Update Auteur"

    assert_text "Auteur was successfully updated"
    click_on "Back"
  end

  test "should destroy Auteur" do
    visit auteur_url(@auteur)
    click_on "Destroy this auteur", match: :first

    assert_text "Auteur was successfully destroyed"
  end
end
