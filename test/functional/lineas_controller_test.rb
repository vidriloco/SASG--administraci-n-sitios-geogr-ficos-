require 'test_helper'

class LineasControllerTest < ActionController::TestCase
  setup do
    @linea = lineas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lineas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create linea" do
    assert_difference('Linea.count') do
      post :create, :linea => @linea.attributes
    end

    assert_redirected_to linea_path(assigns(:linea))
  end

  test "should show linea" do
    get :show, :id => @linea.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @linea.to_param
    assert_response :success
  end

  test "should update linea" do
    put :update, :id => @linea.to_param, :linea => @linea.attributes
    assert_redirected_to linea_path(assigns(:linea))
  end

  test "should destroy linea" do
    assert_difference('Linea.count', -1) do
      delete :destroy, :id => @linea.to_param
    end

    assert_redirected_to lineas_path
  end
end
