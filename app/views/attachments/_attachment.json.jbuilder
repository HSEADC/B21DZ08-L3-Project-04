json.extract! attachment, :id, :type, :post_id, :url, :created_at, :updated_at
json.url attachment_url(attachment, format: :json)
