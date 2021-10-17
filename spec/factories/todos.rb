FactoryBot.define do
  factory :todo do
    user { create(:user) }
    name { "MyString" }
    description { "MyString" }
  end
end
