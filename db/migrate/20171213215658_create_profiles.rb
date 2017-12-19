class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|

      t.references :user, index: true
      t.string :address
      t.string :phone
      t.text :about_me

      t.timestamps
    end

  end
end
