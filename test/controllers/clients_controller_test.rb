require 'test_helper'

class ClientsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  test "should get index and new" do
    get :index
    assert :success

    get :new
    assert :success
  end

  test "should get show and edit" do
    client = FactoryGirl.create(:client, user_id: @user.id)

    get :show, id: client.id
    assert :success

    get :edit, id: client.id
    assert :success
  end
end
