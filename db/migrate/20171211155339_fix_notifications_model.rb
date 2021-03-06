class FixNotificationsModel < ActiveRecord::Migration[5.0]
  def change
    drop_table :notifications

    create_table :notifications do |t|
      t.references :user, index: true
      t.references :notified_by, index: true
      t.integer :identifier
      t.string :notice_type
      t.boolean :read, default: false


      t.timestamps null: false
    end
    add_foreign_key :notifications, :users
    add_foreign_key :notifications, :users, column: :notified_by_id
  end

end
