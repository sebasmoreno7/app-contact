class ContactsController < ApplicationController
    before_action :set_contact, only: %i[show edit update destroy]

    # Muestra la lista de contactos con información relacionada (género, país, departamento, ciudad)
    def index
      @contacts = Contact.includes(:gender, :country, :department, :city).all
  
      respond_to do |format|
        format.html
        format.json { render json: @contacts.as_json(include: { gender: { only: :name }, country: { only: :name }, department: { only: :name }, city: { only: :name } }) }
      end
    end
  
    # Muestra los detalles de un contacto específico
    def show
    end
  
    # Muestra el formulario para crear un nuevo contacto
    def new
      @contact = Contact.new
    end
  
    # Crea un nuevo contacto con los parámetros proporcionados
    def create
      @contact = Contact.new(contact_params)
  
      respond_to do |format|
        if @contact.save
          format.html { redirect_to contacts_path, notice: "Contact created successfully" }
          format.json { render json: @contact, status: :created, location: @contact }
        else
          format.html { render :new }
          format.json { render json: @contact.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # Muestra el formulario para editar un contacto existente
    def edit
    end
  
    # Actualiza la información de un contacto con los parámetros proporcionados
    def update
      respond_to do |format|
        if @contact.update(contact_params)
          format.html { redirect_to contacts_path, notice: "Contact updated successfully" }
          format.json { render json: @contact, status: :created, location: @contact }
        else
          format.html { render :edit }
          format.json { render json: @contact.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # Elimina un contacto existente
    def destroy
      @contact.destroy
      redirect_to contacts_path, notice: 'Contact deleted successfully'
    end
  
    # Exporta la lista de contactos a un archivo PDF
    def export_to_pdf
      @contacts = Contact
        .joins(:gender, :country, :department, :city)
        .select("contacts.*, genders.name as gender_name, countries.name as country_name, departments.name as department_name, cities.name as city_name")
  
      respond_to do |format|
        format.pdf do
          pdf = Prawn::Document.new
          pdf.text "Listado de Contactos", size: 16, align: :center
          pdf.move_down 20
  
          @contacts.each do |contact|
            pdf.text "Nombre: #{contact.name} #{contact.lastname}"
            pdf.text "Fecha de Nacimiento: #{contact.birth_date}"
            pdf.text "Género: #{contact.gender_name}"
            pdf.text "País: #{contact.country_name}"
            pdf.text "Departamento: #{contact.department_name}"
            pdf.text "Ciudad: #{contact.city_name}"
            pdf.text "Email: #{contact.email}"
            pdf.text "Dirección: #{contact.address}"
            pdf.text "Casa/Apartamento: #{contact.house}"
            pdf.text "Descripción: #{contact.description}"
            pdf.move_down 20
          end
  
          send_data pdf.render, filename: "contacts.pdf", type: "application/pdf", disposition: "inline"
        end
      end
    end
  
    private

    def set_contact
      @contact = Contact.find(params[:id])
    end
  
    # Parámetros permitidos para la creación y actualización de un contacto
    def contact_params
      params.require(:contact).permit(
        :gender_id, :country_id, :department_id, :city_id, :birth_date, :name,
        :lastname, :email, :address, :house, :description
      )
    end
end  
