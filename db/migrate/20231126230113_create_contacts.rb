class CreateContacts < ActiveRecord::Migration[7.0]
  def change
    create_table :contacts do |t|
      t.integer :gender_id
      t.integer :country_id
      t.integer :department_id
      t.integer :city_id
      t.date :birth_date
      t.string :name
      t.string :lastname
      t.string :email
      t.string :address
      t.string :house
      t.text :description

      t.timestamps
    end
  end
end
