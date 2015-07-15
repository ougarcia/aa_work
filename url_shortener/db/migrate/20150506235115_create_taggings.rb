class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.string :topic_id
      t.integer :url_id

      t.timestamps
    end

    add_index :taggings, :topic_id
  end
end
