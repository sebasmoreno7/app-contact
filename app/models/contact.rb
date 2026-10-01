class Contact < ApplicationRecord
  belongs_to :gender
  belongs_to :country
  belongs_to :department
  belongs_to :city

  validates :birth_date, :name, :lastname, :email, :address, presence: true
  validate :must_be_adult
  validate :city_has_capacity, on: :create

  private

  def must_be_adult
    return if birth_date.blank?

    if birth_date > 18.years.ago.to_date
      errors.add(:birth_date, "No puede ser menor de 18 años")
    end
  end

  def city_has_capacity
    return if city_id.blank?

    if Contact.where(city_id: city_id).count >= 3
      errors.add(:city_id, "Solo puede haber 3 registros con la misma ciudad")
    end
  end
end
