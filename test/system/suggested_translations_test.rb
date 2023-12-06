require "application_system_test_case"

class SuggestedTranslationsTest < ApplicationSystemTestCase
  setup do
    @suggested_translation = suggested_translations(:one)
  end

  test "visiting the index" do
    visit suggested_translations_url
    assert_selector "h1", text: "Suggested translations"
  end

  test "should create suggested translation" do
    visit suggested_translations_url
    click_on "New suggested translation"

    fill_in "Body", with: @suggested_translation.body
    fill_in "Language", with: @suggested_translation.language
    fill_in "Post", with: @suggested_translation.post_id
    fill_in "User", with: @suggested_translation.user_id
    click_on "Create Suggested translation"

    assert_text "Suggested translation was successfully created"
    click_on "Back"
  end

  test "should update Suggested translation" do
    visit suggested_translation_url(@suggested_translation)
    click_on "Edit this suggested translation", match: :first

    fill_in "Body", with: @suggested_translation.body
    fill_in "Language", with: @suggested_translation.language
    fill_in "Post", with: @suggested_translation.post_id
    fill_in "User", with: @suggested_translation.user_id
    click_on "Update Suggested translation"

    assert_text "Suggested translation was successfully updated"
    click_on "Back"
  end

  test "should destroy Suggested translation" do
    visit suggested_translation_url(@suggested_translation)
    click_on "Destroy this suggested translation", match: :first

    assert_text "Suggested translation was successfully destroyed"
  end
end
