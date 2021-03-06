##
#  Best practice is to create at least one factory for
#  each model with the minimum requirements to get
#  each validation to pass.
##
FactoryBot.define do 
  factory :user do
    sequence(:name) { |n| "Foo Bar#{n}" } 
    # This sequence avoids the email's uniqueness validation from failing
    sequence(:email) { |n| "foo#{n}@example.com" }
    password "secret"

    after(:create) { |user| user.confirm }
  end

  factory :friend_request do
    user
    association :friend, factory: :user
  end

  factory :friendship do
    user
    association :friend, factory: :user
  end

  factory :notification do
    user
    association :notified_by, factory: :user
  end

  factory :post do
    content "test content"
    association :author, factory: :user
  end

  factory :comment do
    content "comment content"
    association :author, factory: :user
    post
  end

  factory :profile do
    user
    address "123 Factroy St."
    phone   "(555)-555-5555"
    about_me "I am a factory profile."
  end

end
