json.array!(@shorts) do |short|
  json.extract! short, :id, :full, :short, :slug
  json.url short_url(short, format: :json)
end
