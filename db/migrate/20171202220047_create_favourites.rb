class CreateFavourites < ActiveRecord::Migration
  def up
    create_table :favourites, :primary_key => "favourite_id" do |t|
      t.references :user
      t.references :article

      t.timestamps
    end
    add_index :favourites, ["user_id", "article_id"]
  end

  def down
    drop_table :favourites
  end
end
