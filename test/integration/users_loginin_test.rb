require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest


  test "login with valid information" do
    u = User.create(:first_name => 'adimi', :last_name => 'admin',
      :user_name => 'qwertyuiop',:email => "sfu3@sfu.ca",
      :birth_date => '12-33-4455', :country => 'ca', :password => 'correctpassword')
    get login_path,
      params:{ user_name: u.user_name, password: 'correctpassword'}
    assert_response :success
    post attempt_login_path,
    params: {
       user_name: u.user_name, password: 'correctpassword'}
    assert_redirected_to controller: "user", action:"display"
    follow_redirect!
    assert_response:success

  end


end
