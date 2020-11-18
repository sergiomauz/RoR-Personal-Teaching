class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :fullname
      t.string :email
      t.string :username
      t.string :password
      t.boolean :admin,             default: false
      
      t.timestamps
    end
  end
end
