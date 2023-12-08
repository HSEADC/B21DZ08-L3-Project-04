json.extract! attachment, :type, :post_id, :url, :created_at
# _image request .base_url + request.original_fullpath + attachment.photo.url
#Вот тут кстати надо додумать насчет вложений и как они передаются


json.url attachment_url(attachment, format: :json)
