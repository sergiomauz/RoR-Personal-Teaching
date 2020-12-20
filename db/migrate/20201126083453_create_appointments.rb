class CreateAppointments < ActiveRecord::Migration[6.0]
  def change
    create_table :appointments do |t|    
      t.integer :user_id,         null: false
      t.integer :teacher_id,      null: false
      t.datetime :scheduled_for,  null: false

      t.timestamps
    end
  end
end
