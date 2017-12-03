class CreateArticles < ActiveRecord::Migration
  def up
    create_table :articles, :primary_key => "article_id" do |t|
      t.string 'source_id'
      t.string 'source_name'
      t.string 'author'
      t.string 'title'
      t.string 'description'
      t.string 'url'
      t.string 'urlToImage'
      t.string 'publishedAt'
      t.references :subscription

      t.timestamps
    end
  end

  def down
    drop_table :articles
  end
end
