Fabricator(:review) do
  body { Faker::Lorem.words(25).join ' ' }
end
