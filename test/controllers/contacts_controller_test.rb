require "test_helper"

class ContactsControllerTest < ActionDispatch::IntegrationTest
  test "invalid contacts return validation errors in HTML and JSON" do
    assert_no_difference "Contact.count" do
      post contacts_path, params: { contact: { name: "" } }
    end
    assert_response :unprocessable_entity
    assert_select "#error_explanation"

    post contacts_path(format: :json), params: { contact: { name: "" } }
    assert_response :unprocessable_entity
    assert response.parsed_body.key?("name")
  end

  test "renders contact list, JSON and PDF after framework upgrade" do
    country = Country.create!(name: "Colombia")
    department = Department.create!(name: "Cundinamarca", country: country)
    city = City.create!(name: "Bogotá", department: department)
    gender = Gender.create!(name: "Otro")
    contact = Contact.create!(
      country: country, department: department, city: city, gender: gender,
      name: "Ana", lastname: "Pérez", email: "ana@example.com",
      address: "Calle 1", birth_date: 18.years.ago.to_date
    )

    get contacts_path
    assert_response :success
    assert_select "a[href=?][data-turbo-method=delete][data-turbo-confirm]", contact_path(contact)

    get contact_path(contact)
    assert_response :success
    assert_select "h1", text: "Ana Pérez"

    get contact_path(contact, format: :json)
    assert_response :success
    assert_equal "Ana", response.parsed_body["name"]

    get contacts_path(format: :json)
    assert_response :success
    assert_equal "Ana", response.parsed_body.find { |row| row["id"] == contact.id }["name"]

    get export_to_pdf_contacts_path
    assert_response :success
    assert_match %r{application/pdf}, response.media_type
    assert response.body.start_with?("%PDF")
  end
end
