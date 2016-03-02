Fabricator(:user) do
  email { Faker::Internet.email }
  password { Faker::Internet.password }
  username { Faker::Name.name }
end
