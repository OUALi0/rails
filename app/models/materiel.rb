class Materiel < ApplicationRecord
    has_and_belongs_to_many :emprunts
end
