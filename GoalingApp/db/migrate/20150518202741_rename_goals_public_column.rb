class RenameGoalsPublicColumn < ActiveRecord::Migration
  def change
    remove_column :goals, :public, :boolean
    add_column :goals, :publicized, :boolean
  end
end
