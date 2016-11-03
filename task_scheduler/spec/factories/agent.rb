FactoryGirl.define do
  factory :agent, class: Agent do
    sequence(:secret_key) { |n| "Secret#{n}" }
    sequence(:decode_key) { |n| "DecodeSecret#{n}" }

    trait :invalid_parameters do
      secret_key nil
      decode_key nil
    end

    factory :invalid_agent, traits: [:invalid_parameters]
  end
end
