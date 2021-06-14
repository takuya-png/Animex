class CreateTopics < ActiveRecord::Migration[5.2]
  def change
    create_table :topics do |t|
      t.bigint :topic_id
      t.string :title
      t.text :description
      t.bigint :user_id

      t.timestamps
    end
  end
end
