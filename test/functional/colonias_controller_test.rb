require 'test_helper'

class ColoniasControllerTest < ActionController::TestCase
  setup do
    @colonia = colonias(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:colonias)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create colonia" do
    assert_difference('Colonia.count') do
      post :create, :colonia => @colonia.attributes
    end

    assert_redirected_to colonia_path(assigns(:colonia))
  end

  test "should show colonia" do
    get :show, :id => @colonia.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @colonia.to_param
    assert_response :success
  end

  test "should update colonia" do
    put :update, :id => @colonia.to_param, :colonia => @colonia.attributes
    assert_redirected_to colonia_path(assigns(:colonia))
  end

  test "should destroy colonia" do
    assert_difference('Colonia.count', -1) do
      delete :destroy, :id => @colonia.to_param
    end

    assert_redirected_to colonias_path
  end
end
