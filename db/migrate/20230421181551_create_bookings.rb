class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.belongs_to :pet_type, null: false
      t.string :owner_first_name, null: false
      t.string :owner_last_name, null: false
      t.string :pet_name, null: false
      t.integer :duration, null: false
      t.datetime :date, null: false
      t.money :price, null: false

      t.timestamps
    end
  end
end
