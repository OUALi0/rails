class Emprunt < ApplicationRecord
    has_and_belongs_to_many :materiels
    has_and_belongs_to_many :documents
    belongs_to :adherent
end
