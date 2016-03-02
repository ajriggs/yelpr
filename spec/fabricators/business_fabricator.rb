Fabricator(:business) do
  name { Faker::Lorem.words(2).join ' ' }
end
