class CreateEmployees < ActiveRecord::Migration[6.0]
  def change
    create_table :employees do |t|
      t.string :name
      t.text :address
      t.string :email
      t.integer :phone
      t.date :dob
      t.binary :profile_image

      t.timestamps
    end
    add_index :employees, :email, unique: true
  end
end
