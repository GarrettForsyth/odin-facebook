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

end
