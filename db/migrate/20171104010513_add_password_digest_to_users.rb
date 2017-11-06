class AddPasswordDigestToUsers < ActiveRecord::Migration
  def up

  	remove_column "users", "password"
  	add_column "users","password_digest", :string
  end

  def down
  	add_column "users", "password", :string, :null => false
  	remove_column "users" , "password_digest"
 end
end
