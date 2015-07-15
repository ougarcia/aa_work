class CreateSubs < ActiveRecord::Migration
  def change
    create_table :subs do |t|
      t.string :title, index: true, unique: true
      t.string :description
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
