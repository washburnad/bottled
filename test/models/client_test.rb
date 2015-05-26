require 'test_helper'

class ClientTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "Should add collaboration" do 
    user1 = FactoryGirl.create(:user)
    client = FactoryGirl.create(:client, user_id: user1.id)
    user2 = FactoryGirl.create(:user)

    assert_difference('Collaboration.count') do 
      client.add_collaborator(user2)
    end

    c = Collaboration.last
    assert_equal user2.id, c.user_id, "User id should match collaboration user_id"
    assert_equal client.id, c.client_id, "Client id should match collaboration"

  end

  test "Should fail collaboration because same user" do 
    user = FactoryGirl.create(:user)
    client = FactoryGirl.create(:client, user_id: user.id)

    assert_no_difference('Collaboration.count') do  
      client.add_collaborator(user)
    end

  end

  test "Should get collaborating user from email" do 
    client = FactoryGirl.create(:client)
    user = FactoryGirl.create(:user)
    collaboration_params = {collaborator_string: user.email}

    assert_equal user, Client.collaborating_user(collaboration_params)
  end


  test "Should get collaborating user from id" do 
    client = FactoryGirl.create(:client)
    user = FactoryGirl.create(:user)
    collaboration_params = {collaborator_string: user.id.to_s}

    assert_equal user, Client.collaborating_user(collaboration_params)
  end

  test "Should check if client is collaborator" do 
    client = FactoryGirl.create(:client)
    user = FactoryGirl.create(:user)
    collaboration = FactoryGirl.create(:collaboration, client_id: client.id, user_id: user.id)

    assert client.collaborator?(user)
  end

  test "Should return array of collaborators" do 
    client = FactoryGirl.create(:client)
    user1 = FactoryGirl.create(:user)
    collaboration = FactoryGirl.create(:collaboration, client_id: client.id, user_id: user1.id)
    user2 = FactoryGirl.create(:user)
    collaboration = FactoryGirl.create(:collaboration, client_id: client.id, user_id: user2.id)

    client_collaborators = [user1, user2]

    assert_equal client_collaborators, client.collaborators
  end

end
