require "test_helper"

class SuggestedTranslationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @suggested_translation = suggested_translations(:one)
  end

  test "should get index" do
    get suggested_translations_url
    assert_response :success
  end

  test "should get new" do
    get new_suggested_translation_url
    assert_response :success
  end

  test "should create suggested_translation" do
    assert_difference("SuggestedTranslation.count") do
      post suggested_translations_url, params: { suggested_translation: { body: @suggested_translation.body, language: @suggested_translation.language, post_id: @suggested_translation.post_id, user_id: @suggested_translation.user_id } }
    end

    assert_redirected_to suggested_translation_url(SuggestedTranslation.last)
  end

  test "should show suggested_translation" do
    get suggested_translation_url(@suggested_translation)
    assert_response :success
  end

  test "should get edit" do
    get edit_suggested_translation_url(@suggested_translation)
    assert_response :success
  end

  test "should update suggested_translation" do
    patch suggested_translation_url(@suggested_translation), params: { suggested_translation: { body: @suggested_translation.body, language: @suggested_translation.language, post_id: @suggested_translation.post_id, user_id: @suggested_translation.user_id } }
    assert_redirected_to suggested_translation_url(@suggested_translation)
  end

  test "should destroy suggested_translation" do
    assert_difference("SuggestedTranslation.count", -1) do
      delete suggested_translation_url(@suggested_translation)
    end

    assert_redirected_to suggested_translations_url
  end
end
