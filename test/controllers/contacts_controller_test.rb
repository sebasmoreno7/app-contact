require "test_helper"

class ContactsControllerTest < ActionDispatch::IntegrationTest
  test "renders contact list, JSON and PDF after framework upgrade" do
    country = Country.create!(name: "Colombia")
    department = Department.create!(name: "Cundinamarca", country: country)
    city = City.create!(name: "Bogotá", department: department)
    gender = Gender.create!(name: "Otro")
    Contact.create!(
      country: country, department: department, city: city, gender: gender,
      name: "Ana", lastname: "Pérez", email: "ana@example.com",
      address: "Calle 1", birth_date: 18.years.ago.to_date
    )

    get contacts_path
    assert_response :success

    get contacts_path(format: :json)
    assert_response :success
    assert_equal "Ana", response.parsed_body.first["name"]

    get export_to_pdf_contacts_path
    assert_response :success
    assert_match %r{application/pdf}, response.media_type
    assert response.body.start_with?("%PDF")
  end
end
