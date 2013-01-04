require 'test_helper'

class Api::MessagesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get send" do
    get :send
    assert_response :success
  end

  test "should get delete" do
    get :delete
    assert_response :success
  end

end
