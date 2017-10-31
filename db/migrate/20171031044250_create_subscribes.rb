class CreateSubscribes < ActiveRecord::Migration
  def up
    create_table :subscribes, :primary_key => "subscribe_id" do |t|
      t.references :user
      t.references :subscription
      t.boolean "favourite", :default => false

      t.timestamps
    end
    add_index :subscribes, ["user_id", "subscription_id"]
  end

  def down
    drop_table :subscribes
  end

end
