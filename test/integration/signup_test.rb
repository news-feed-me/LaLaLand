require 'test_helper'

class SignUpTest < ActionDispatch::IntegrationTest

  test "sign up test" do
    get signup_path, params: { user: {first_name: '11', last_name: '1111',
       user_name: 'gfjkjhghjkl', email: 'nja@fu.ca',
       password: '12345678', password_confirmation: '12345678',
        birth_date: '2017-12-20'}, sources: ["ABC News (AU)",
          "Al Jazeera English"] }
    assert_response :success
    post create_path, params: { user: {first_name: '11', last_name: '1111',
       user_name: 'gfjkjhghjkl', email: 'nja@fu.ca',
       password: '12345678', password_confirmation: '12345678',
        birth_date: '2017-12-20'}, sources: ["ABC News (AU)",
          "Al Jazeera English"] }
    assert_response :redirect
  end
end
