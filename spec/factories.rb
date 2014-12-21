FactoryGirl.define do
  factory :todo do
    title 'test todo'

    trait :completed do
      completed true
    end
  end
end
