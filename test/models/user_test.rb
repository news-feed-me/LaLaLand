require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "invalid without a password" do
    u = users(:one)
    assert !u.valid?, "password present validation failed"
  end

  test "valid user is valid" do
    u = User.new(:first_name => "abcdef",
    :last_name => "kalnglkn",
    :user_name => "two123456",
    :email => "jjing@ji.com",
    :birth_date => "11-11-11",
    :country => "canada",
  :password => "1234567890")
    assert u.valid?, "valid user failed"
  end

  test "user not valid username too short" do
    u = User.new(:first_name => "abcdef",
    :last_name => "kalnglkn",
    :user_name => "name",
    :email => "jjingg@ji.com",
    :birth_date => "11-11-11",
    :country => "canada",
  :password => "1234567890")
    assert !u.valid?, "username too short validation failed"
    end

  test "invalid without a first_name" do
    u = User.new(
    :last_name => "kalnglkn",
    :user_name => "two12345",
    :email => "jjingg@ji.com",
    :birth_date => "11-11-11",
    :country => "canada",
  :password => "1234567890")
    assert !u.valid?, "first_name present validation failed"
  end

  test "invalid without a last_name" do
    u = User.new(
    :first_name => "abcded",

    :user_name => "two12345",
    :email => "jjingg@ji.com",
    :birth_date => "11-11-11",
    :country => "canada",
  :password => "1234567890")
    assert !u.valid?, "last_name present validation failed"
  end

  test "invalid without a email" do
    u = User.new(
    :first_name => "abcded",
    :last_name => "lastname",
    :user_name => "two12345",

    :birth_date => "11-11-11",
    :country => "canada",
  :password => "1234567890")
    assert !u.valid?, "last_name present validation failed"
  end

  test "invalid user duplicate user_name" do
      u = User.new(:first_name => "abcdef",
      :last_name => "kalnglkn",
      :user_name => "one12345",
      :email => "jjing@ji.com",
      :birth_date => "11-11-11",
      :country => "canada",
    :password => "1234567890")
      assert !u.valid?, "user_name unique validation failed"
    end

  test "invalid user duplicate email" do
      u = User.new(:first_name => "abcdef",
      :last_name => "kalnglkn",
      :user_name => "one123456",
      :email => "one@sfu.ca",
      :birth_date => "11-11-11",
      :country => "canada",
    :password => "1234567890")
      assert !u.valid?, "email unique validation failed"
    end

    test "user not valid password too short" do
      u = User.new(:first_name => "abcdef",
      :last_name => "kalnglkn",
      :user_name => "one1234567",
      :email => "jjingg@ji.com",
      :birth_date => "11-11-11",
      :country => "canada",
    :password => "123456")
      assert !u.valid?, "password too short validation failed"
      end

    test "user not valid wrong email format" do
        u = User.new(:first_name => "abcdef",
        :last_name => "kalnglkn",
        :user_name => "two123456",
        :email => "1",
        :birth_date => "11-11-11",
        :country => "canada",
      :password => "1234567890")
        assert !u.valid?, "email validation failed"
      end
end
