FactoryBot.define do
  factory :library_book do
    title { Faker::Book.title }
    author { Faker::Book.author }
    isbn { Faker::Number.unique.number(digits: 13).to_s } # Ensures unique ISBN
  end
end
