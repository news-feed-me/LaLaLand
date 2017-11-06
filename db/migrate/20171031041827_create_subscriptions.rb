class CreateSubscriptions < ActiveRecord::Migration
  def up
    create_table :subscriptions, :primary_key => "subscription_id" do |t|
      t.string "name", :limit => 255
      t.string "url"
      t.string "source_id", :unique => true
      t.string "category", :limit => 255

      t.timestamps
    end
  end

  def down
    drop_table :subscriptions
  end

end
