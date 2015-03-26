require 'test_helper'

class ClientTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "Should add collaboration" do 
    client = FactoryGirl.create(:client)
    user = FactoryGirl.create(:user)

    assert_difference('Collaboration.count') do 
      client.add_collaborator(user)
    end

    c = Collaboration.last
    assert_equal user.id, c.user_id, "User id should match collaboration user_id"
    assert_equal client.id, c.client_id, "Client id should match collaboration"

  end

end
