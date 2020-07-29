json.extract! product, :id, :user_id, :title, :description, :quantity, :created_at, :updated_at
json.url product_url(product, format: :json)
