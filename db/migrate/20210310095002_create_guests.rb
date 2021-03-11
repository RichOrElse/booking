class CreateGuests < ActiveRecord::Migration[6.0]
  def change
    create_table :guests do |t|
      t.string :email
      t.string :first_name
      t.string :last_name
      t.json :phone_numbers

      t.timestamps
    end
    add_index :guests, :email, unique: true
  end
end
