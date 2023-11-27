class Contact < ApplicationRecord
    # Asociaciones con otras tablas
    belongs_to :gender
    belongs_to :country
    belongs_to :department
    belongs_to :city
  
    # Validaciones de presencia para algunos campos
    validates :birth_date, presence: true
    validates :name, presence: true
    validates :lastname, presence: true
    validates :email, presence: true
    validates :address, presence: true
  
    # Validación personalizada para verificar si la persona es menor de edad
    validate :menor_de_edad?, on: :create
  
    # Callback ejecutado antes de guardar el contacto para verificar si es menor de edad
    before_save :menor_de_edad?
  
    # Método privado para verificar si la persona es menor de edad
    private
  
    def menor_de_edad?
      if birth_date.present? && (Time.now.year - birth_date.year < 18)
        errors.add(:birth_date, "No puede ser menor de 18 años")
        throw(:abort)
      end
    end
  
    # Validación personalizada para verificar el límite de registros por ciudad al crear uno nuevo
    validate :limite_de_registros_por_ciudad, on: :create
  
    def limite_de_registros_por_ciudad
      # Verifica si hay más de 3 registros con la misma ciudad
      if Contact.where(city_id: city_id).count >= 3
        errors.add(:city_id, "Solo puede haber 3 registros con la misma ciudad")
      end
    end
 end
  