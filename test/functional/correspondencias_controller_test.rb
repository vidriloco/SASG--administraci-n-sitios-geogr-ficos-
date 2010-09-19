require 'test_helper'

class CorrespondenciasControllerTest < ActionController::TestCase
  setup do
    @correspondencia = correspondencias(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:correspondencias)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create correspondencia" do
    assert_difference('Correspondencia.count') do
      post :create, :correspondencia => @correspondencia.attributes
    end

    assert_redirected_to correspondencia_path(assigns(:correspondencia))
  end

  test "should show correspondencia" do
    get :show, :id => @correspondencia.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @correspondencia.to_param
    assert_response :success
  end

  test "should update correspondencia" do
    put :update, :id => @correspondencia.to_param, :correspondencia => @correspondencia.attributes
    assert_redirected_to correspondencia_path(assigns(:correspondencia))
  end

  test "should destroy correspondencia" do
    assert_difference('Correspondencia.count', -1) do
      delete :destroy, :id => @correspondencia.to_param
    end

    assert_redirected_to correspondencias_path
  end
end
