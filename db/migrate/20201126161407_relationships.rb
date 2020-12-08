class Relationships < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :appointments, :users, column: :user_id
    add_index :appointments, :user_id

    add_foreign_key :appointments, :teachers, column: :teacher_id
    add_index :appointments, :teacher_id
  end
end
