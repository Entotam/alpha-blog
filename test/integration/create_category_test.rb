require "test_helper"

class CreateCategoryTest < ActionDispatch::IntegrationTest
  test "get new category form and create category" do
    get "/categories/new"
    assert_response :success
    assert_difference 'Category.count', 1 do
      post categories_path, params: { category: { name: "Travel" } }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "Travel", response.body
  end
end

class CreateCategoryTest < ActionDispatch::IntegrationTest
  test "get new category form and reject invalid category sunmision" do
    get "/categories/new"
    assert_response :success
    assert_no_difference 'Category.count' do
      post categories_path, params: { category: { name: " " } }
    end
    assert_select "h3"
    assert_match "The following errors", response.body
  end
end