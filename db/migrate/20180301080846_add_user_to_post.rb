class AddUserToPost < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :user_id, :integer
    remove_column :posts, :body
  end
end
