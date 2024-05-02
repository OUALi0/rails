require "application_system_test_case"

class AdherentsTest < ApplicationSystemTestCase
  setup do
    @adherent = adherents(:one)
  end

  test "visiting the index" do
    visit adherents_url
    assert_selector "h1", text: "Adherents"
  end

  test "should create adherent" do
    visit adherents_url
    click_on "New adherent"

    fill_in "Id", with: @adherent.id
    fill_in "Nom", with: @adherent.nom
    fill_in "Prenom", with: @adherent.prenom
    click_on "Create Adherent"

    assert_text "Adherent was successfully created"
    click_on "Back"
  end

  test "should update Adherent" do
    visit adherent_url(@adherent)
    click_on "Edit this adherent", match: :first

    fill_in "Id", with: @adherent.id
    fill_in "Nom", with: @adherent.nom
    fill_in "Prenom", with: @adherent.prenom
    click_on "Update Adherent"

    assert_text "Adherent was successfully updated"
    click_on "Back"
  end

  test "should destroy Adherent" do
    visit adherent_url(@adherent)
    click_on "Destroy this adherent", match: :first

    assert_text "Adherent was successfully destroyed"
  end
end
