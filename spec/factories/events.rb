# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    title { Faker::Lorem.word }
    content { Faker::Lorem.paragraph_by_chars(number: 100) }
    held_at { 1.month.from_now }
    prefecture_id { [*1..47].sample }
    user
  end
end
