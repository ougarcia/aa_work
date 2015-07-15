class AddParentIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :parent_post_id, :integer
    Comment.all.each do |comment|
      comment.parent_post_id = comment.root_parent.id
      comment.save
    end
  end
end
