# README

Esta es una aplicación simple de contactos desarrollada en Ruby on Rails.
Requisitos Previos

Asegúrate de tener instalado:

    Ruby (versión 3.0.0 recomendada)
    Rails (versión 7.0.0 recomendada)
    SQLite (o la base de datos de tu elección)

Configuración

    Clona el repositorio:

    bash

git clone https://tu-repositorio.git
cd contact-app

Instala las gemas:

bash

bundle install

Configura la base de datos:

bash

rails db:create
rails db:migrate

Inicia el servidor:

bash

rails server

La aplicación estará disponible en http://localhost:3000.

Se tiene el siguiente endpoint para traer los contactos creados:
GET  http://localhost:3000/contacts
Para el caso puntual se usó Postman
Headers: "Accept", "application/json"


Para las consultas se tienen desde el ORM
@contacts = Contact
      .joins(:gender, :country, :department, :city)
      .select("contacts.*, genders.name as gender_name, countries.name as country_name, departments.name as department_name, cities.name as city_name")

Para consultas desde MySql
SELECT 
  contacts.*,
  genders.name AS gender_name,
  countries.name AS country_name,
  departments.name AS department_name,
  cities.name AS city_name
FROM 
  contacts
JOIN 
  genders ON contacts.gender_id = genders.id
JOIN 
  countries ON contacts.country_id = countries.id
JOIN 
  departments ON contacts.department_id = departments.id
JOIN 
  cities ON contacts.city_id = cities.id;
