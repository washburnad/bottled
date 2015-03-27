require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "Should find user by id string and email" do 
    user = FactoryGirl.create(:user)

    assert_equal user, User.user_from_id_or_email(user.id.to_s), "Should get user from id string"
    assert_equal user, User.user_from_id_or_email(user.email), "Should get user from email"
  end
end
