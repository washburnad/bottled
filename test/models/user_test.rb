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

  test "Should return user full name" do 
    user = FactoryGirl.create(:user, first_name: 'John', last_name: 'Doe')

    assert_equal 'John Doe', user.name
  end

  test "Should return space for nil names" do 
    user = FactoryGirl.create(:user, first_name: nil, last_name: nil)

    assert_equal '', user.name
  end

  test 'Should return sorted array of clients and collaborators' do
    setup_user_clients

    assert_equal 3, @user.all_clients.count
    assert_equal 6, @user2.all_clients.count

    expected = @user2.all_clients.sort_by do |client|
      client['name']
    end

    assert_equal expected, @user2.all_clients('name'), 'Should sort clients by name'
  end

  def setup_user_clients
    @user = FactoryGirl.create(:user)
    @user2 = FactoryGirl.create(:user)
    3.times do |n|
      @user2.clients.create(name: "#{10-n} client")
    end
    3.times do 
      FactoryGirl.create(:client, user_id: @user.id)
    end
    @user.clients.each do |client|
      FactoryGirl.create(:collaboration, client_id: client.id, user_id: @user2.id)
    end

  end
end
