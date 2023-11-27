class AddFirstData < ActiveRecord::Migration[7.0]
  def change
    # Agrega los datos al modelo `Gender`
    Gender.create!(name: 'Hombre')
    Gender.create!(name: 'Mujer')
    Gender.create!(name: 'Otro')

    # Agrega los datos al modelo `Country`
    Country.create!(name: 'Colombia')
    Country.create!(name: 'Argentina')
    Country.create!(name: 'Brasil')

    # Agrega los datos al modelo `Department`
    Department.create!(name: 'Cundinamarca', country_id: 1)
    Department.create!(name: 'Antioquia', country_id: 1)
    Department.create!(name: 'Caldas', country_id: 1)

    # Agrega los datos al modelo `City`
    City.create!(name: 'Bogotá', department_id: 1)
    City.create!(name: 'Medellín', department_id: 2)
    City.create!(name: 'Manizales', department_id: 3)

  end
end
