json.array!(@items) do |item|
  json.extract! item, :id, :name, :price, :on_sale
  json.url api_item_url(item, format: :json)
end
