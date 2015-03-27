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

  test "Should fail collaboration because same user id" do 
    user = FactoryGirl.create(:user)
    client = FactoryGirl.create(:client, user_id: user.id)

    assert_no_difference('Collaboration.count') do  
      client.add_collaborator(user)
    end

  end

end
