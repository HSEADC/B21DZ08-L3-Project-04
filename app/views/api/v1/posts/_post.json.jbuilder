json.extract! post, :title, :text, :created_at
json.url api_v1_post_url(post, format: :json)

# json.set! :posts do
#     json.array! @posts, partial: "api/v1/posts/post", as: :post
# end