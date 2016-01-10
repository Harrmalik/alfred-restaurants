json.array!(@restaurants) do |restaurant|
  json.extract! restaurant, :id, :name, :description, :quality, :price, :environment, :overall
  json.url restaurant_url(restaurant, format: :json)
end
