json.array!(@purchase_headers) do |purchase_header|
  json.extract! purchase_header, :id, :amount, :purchase_details, :created_at
  json.url api_purchase_header_url(purchase_header, format: :json)
end
