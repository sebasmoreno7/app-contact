class CreateDepartments < ActiveRecord::Migration[7.0]
  def change
    create_table :departments do |t|
      t.string :name
      t.integer :country_id
      t.timestamps
    end
  end
end
