class AddUserIdToTopics < ActiveRecord::Migration[5.2]
  def change
    add_column :topics, :user_id, :bigint
  end
end
