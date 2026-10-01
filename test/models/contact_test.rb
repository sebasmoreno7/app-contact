require "test_helper"

class ContactTest < ActiveSupport::TestCase
  setup do
    country = Country.create!(name: "Colombia")
    department = Department.create!(name: "Cundinamarca", country: country)
    city = City.create!(name: "Bogotá", department: department)
    gender = Gender.create!(name: "Otro")

    @attributes = {
      country: country, department: department, city: city, gender: gender,
      name: "Ana", lastname: "Pérez", email: "ana@example.com",
      address: "Calle 1", birth_date: 18.years.ago.to_date
    }
  end

  test "accepts someone on their eighteenth birthday" do
    assert Contact.new(@attributes).valid?
  end

  test "rejects someone one day under eighteen without aborting validation" do
    contact = Contact.new(@attributes.merge(birth_date: 18.years.ago.to_date + 1.day))

    assert_not contact.valid?
    assert contact.errors[:birth_date].any?
  end

  test "checks age again when birth date changes" do
    contact = Contact.create!(@attributes)

    assert_not contact.update(birth_date: 18.years.ago.to_date + 1.day)
    assert contact.errors[:birth_date].any?
  end

  test "allows at most three contacts per city" do
    3.times do |index|
      Contact.create!(@attributes.merge(email: "person#{index}@example.com"))
    end

    fourth = Contact.new(@attributes.merge(email: "fourth@example.com"))
    assert_not fourth.valid?
    assert fourth.errors[:city_id].any?
  end
end
