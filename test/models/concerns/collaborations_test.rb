require 'test_helper'

class CollaborationsTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "Should check if user is collaborator" do 
    setup_client_and_collaborators

    assert @client.collaborator?(@user2)
    assert @client.collaborator?(@user3)
  end

  test "Should return array of collaborators" do 
    setup_client_and_collaborators

    expected = [@user2, @user3]

    assert_equal expected, @client.collaborators
  end

  def setup_client_and_collaborators
    @user1 = FactoryGirl.create(:user)
    @user2 = FactoryGirl.create(:user)
    @user3 = FactoryGirl.create(:user)
    @client = FactoryGirl.create(:client, user_id: @user1.id)
    @client.collaborations.create(user: @user2)
    @client.collaborations.create(user: @user3)
  end
end