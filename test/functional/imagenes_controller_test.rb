require 'test_helper'

class ImagenesControllerTest < ActionController::TestCase
  setup do
    @imagen = imagenes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:imagenes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create imagen" do
    assert_difference('Imagen.count') do
      post :create, :imagen => @imagen.attributes
    end

    assert_redirected_to imagen_path(assigns(:imagen))
  end

  test "should show imagen" do
    get :show, :id => @imagen.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @imagen.to_param
    assert_response :success
  end

  test "should update imagen" do
    put :update, :id => @imagen.to_param, :imagen => @imagen.attributes
    assert_redirected_to imagen_path(assigns(:imagen))
  end

  test "should destroy imagen" do
    assert_difference('Imagen.count', -1) do
      delete :destroy, :id => @imagen.to_param
    end

    assert_redirected_to imagenes_path
  end
end
