class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.references :author, index: true
      t.references :post, index: true
      t.string :content

      t.timestamps
    end

    add_foreign_key :comments, :users, column: :author_id
    add_foreign_key :comments, :posts
  end
end
