json.extract! document, :id, :doc_type, :titre, :isbn, :created_at, :updated_at
json.url document_url(document, format: :json)
