class CreateReservations < ActiveRecord::Migration[6.0]
  def change
    create_table :reservations do |t|
      t.belongs_to :guest, null: false, foreign_key: true
      t.string :status
      t.date :start_date
      t.date :end_date
      t.integer :nights
      t.integer :number_of_guests
      t.integer :number_of_adults
      t.integer :number_of_children
      t.integer :number_of_infants
      t.string :description
      t.string :currency
      t.monetize :payout_price, with_model_currency: :currency
      t.monetize :security_price, with_model_currency: :currency
      t.monetize :total_price, with_model_currency: :currency

      t.timestamps
    end
  end
end
