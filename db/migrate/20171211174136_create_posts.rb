class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.text :content
      t.references :author, index: true

      t.timestamps
    end

    add_foreign_key :posts, :users, column: :author_id
  end
end
