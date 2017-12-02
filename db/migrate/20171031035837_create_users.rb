class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users, :primary_key => "user_id" do |t|
      t.string "first_name", :limit => 255
      t.string "last_name", :limit => 255
      t.string "user_name", :limit => 255, :unique => true, :null => false
      t.string "email", :limit => 255
      t.date "birth_date"
      t.string "password", :null => false
      t.string "country", :limit => 255
      t.binary "profile_picture"

      t.timestamps
    end
  end

  def down
    drop_table :users
  end
end
