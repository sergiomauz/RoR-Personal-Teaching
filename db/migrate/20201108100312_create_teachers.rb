class CreateTeachers < ActiveRecord::Migration[6.0]
  def change
    create_table :teachers do |t|
      t.string :fullname,     null: false, limit: 75
      t.string :email,        null: false, limit: 50
      t.string :photo,        null: true
      t.string :course,       null: false, limit: 50
      t.string :description,  null: false, limit: 150

      t.timestamps
    end
  end
end
