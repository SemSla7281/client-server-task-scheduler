FactoryGirl.define do
  factory :task, class: Task do
    sequence(:name) { |n| "Task #{n}" }
    path '~/tasks/task1.sh'
    arguments 'a1 a2'
    start_time Time.now
    end_time Time.now + 3.days
    weekdays %w(sunday monday thursday)

    trait :invalid_parameters do
      name nil
      path nil
      start_time nil
      end_time nil
      weekdays nil
      agent nil
    end

    factory :invalid_task, traits: [:invalid_parameters]

    trait :full_week do
      start_time Time.zone.now + 1.day
      end_time Time.zone.now + 8.days
      weekdays WEEKDAYS
    end

    factory :full_week, traits: [:full_week]

    trait :partial_week do
      start_time Time.zone.now + 1.day
      end_time Time.zone.now + 8.days
      weekdays %w(tuesday thursday)
    end

    factory :partial_week, traits: [:partial_week]

    before :create do |task, evaluator|
      task.agent = evaluator.agent || FactoryGirl.create(:agent)
    end
  end
end
