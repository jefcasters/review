json.array!(@documents) do |document|
  json.extract! document, :id, :title, :image
  json.url document_url(document, format: :json)
end
