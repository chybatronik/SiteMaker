json.array!(@sites) do |site|
  json.extract! site, :name, :description, :user_id
  json.url site_url(site, format: :json)
end
