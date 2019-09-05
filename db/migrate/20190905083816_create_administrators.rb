class CreateAdministrators < ActiveRecord::Migration[5.0]
  def change
    create_table :administrators do |t|
      t.string :name, null: false
      t.string :password_digest, null: false

      t.timestamps
    end
  end
end
