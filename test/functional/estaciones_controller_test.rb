require 'test_helper'

class EstacionesControllerTest < ActionController::TestCase
  setup do
    @estacion = estaciones(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:estaciones)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create estacion" do
    assert_difference('Estacion.count') do
      post :create, :estacion => @estacion.attributes
    end

    assert_redirected_to estacion_path(assigns(:estacion))
  end

  test "should show estacion" do
    get :show, :id => @estacion.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @estacion.to_param
    assert_response :success
  end

  test "should update estacion" do
    put :update, :id => @estacion.to_param, :estacion => @estacion.attributes
    assert_redirected_to estacion_path(assigns(:estacion))
  end

  test "should destroy estacion" do
    assert_difference('Estacion.count', -1) do
      delete :destroy, :id => @estacion.to_param
    end

    assert_redirected_to estaciones_path
  end
end
