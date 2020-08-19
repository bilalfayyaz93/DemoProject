ThinkingSphinx::Index.define :product, with: :active_record do
  # fields
  indexes title
  indexes description
  indexes user.name, as: :user_name
end
