class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :objective
      t.references :user, index: true, foreign_key: true
      t.boolean :completed
      t.boolean :public

      t.timestamps null: false
    end
  end
end
