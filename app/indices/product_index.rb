ThinkingSphinx::Index.define :product, with: :real_time do
  # fields
  indexes title, sortable: true
  indexes description
  indexes user.name, as: :user_name

  #attributes
  has quantity, type: :integer
  has price, type: :integer
  has user_id, type: :integer
  has created_at, type: :timestamp
  has updated_at, type: :timestamp
end
