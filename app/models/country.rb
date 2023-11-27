class Country < ApplicationRecord
    has_many :departments
    validates :name, presence: true
end
