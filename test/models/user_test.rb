require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "invalid without a password" do
    u = users(:one)
    assert !u.valid?, "user not valid it dosent have a password"
  end
  #test "user should not save" do
  #  assert true
  #end
end
