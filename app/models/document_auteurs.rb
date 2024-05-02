class DocumentAuteur < ApplicationRecord
    attr_accessor :auteur_id, :document_id

    def initialize(auteur_id, document_id)
      @auteur_id = auteur_id
      @document_id = document_id
    end
end
