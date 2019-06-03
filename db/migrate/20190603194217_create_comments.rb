class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.string :content
      t.integer :movie_id

      t.timestamps
    end

    add_index :comments, [:user_id, :movie_id], unique: true
  end
end
