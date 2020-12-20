class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :fullname,   null: false, limit: 75
      t.string :email,      null: false, limit: 50
      t.string :username,   null: false, limit: 15
      t.string :password,   null: false      
      t.boolean :admin,     default: false
      
      t.timestamps
    end
  end
end
