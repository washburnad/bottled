require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "should render index" do
    get :index
    assert :success
  end

  test "Should render about" do
    get :about
    assert :success
  end
end
