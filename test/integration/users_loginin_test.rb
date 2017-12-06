require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest


  test "login with valid information" do
    u = users(:one)
    get login_path,
      params:{ user_name: u.user_name, password: 'correctpassword'}
    assert_response :success
    post attempt_login_path,
      params: { user: {
         user_name: u.user_name, password: 'correctpassword'} }
    assert_redirected_to controller: "access", action:"login"
    follow_redirect!
    assert_response:success

  end
end
