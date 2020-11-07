class CreateTeachers < ActiveRecord::Migration[6.0]
  def change
    create_table :teachers do |t|
      t.string :fullname
      t.string :email
      t.string :photo
      t.string :course
      t.string :description

      t.timestamps
    end
  end
end
