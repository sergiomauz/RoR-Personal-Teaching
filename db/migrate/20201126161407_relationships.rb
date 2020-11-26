class Relationships < ActiveRecord::Migration[6.0]
  def change
    add_reference :appointments, :users, foreign_key: true, null: false
    add_reference :appointments, :teachers, foreign_key: true, null: false
  end
end
