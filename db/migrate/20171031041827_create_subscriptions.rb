class CreateSubscriptions < ActiveRecord::Migration
  def up
    create_table :subscriptions, :primary_key => subscription_id do |t|
      t.string "name", :limit => 255
      t.string "url", :limit => 255
      t.string "geography", :limit => 255
      t.string "json_reference", :limit => 255

      t.timestamps null: false
    end
  end

  def down
    drop_table :subscriptions
  end

end
