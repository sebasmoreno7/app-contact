class Department < ApplicationRecord
    belongs_to :country
    has_many :cities
    validates :name, presence: true
end
