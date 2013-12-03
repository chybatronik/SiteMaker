json.array!(@pages) do |page|
  json.extract! page, :name_file, :layout, :permalink, :published, :categories, :tags, :title, :content, :date, :site_id
  json.url page_url(page, format: :json)
end
