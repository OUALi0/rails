class Document < ApplicationRecord
  has_and_belongs_to_many :auteurs
  has_and_belongs_to_many :emprunts
end
