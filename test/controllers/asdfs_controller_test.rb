require 'test_helper'

class AsdfsControllerTest < ActionController::TestCase
  setup do
    @asdf = asdfs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:asdfs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create asdf" do
    assert_difference('Asdf.count') do
      post :create, asdf: {  }
    end

    assert_redirected_to asdf_path(assigns(:asdf))
  end

  test "should show asdf" do
    get :show, id: @asdf
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @asdf
    assert_response :success
  end

  test "should update asdf" do
    patch :update, id: @asdf, asdf: {  }
    assert_redirected_to asdf_path(assigns(:asdf))
  end

  test "should destroy asdf" do
    assert_difference('Asdf.count', -1) do
      delete :destroy, id: @asdf
    end

    assert_redirected_to asdfs_path
  end
end
