json.extract! post, :title, :text, :created_at
json.url api_v1_post_url(post, format: :json)
