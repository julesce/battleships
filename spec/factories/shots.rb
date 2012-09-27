FactoryGirl.define do
  factory :shot do
    board
    is_hit false

    # Lets make a factory available with 1 co_ordinate
    factory :shot_with_co_ordinates do
      ignore do
        co_ordinates_count 1
      end

      after(:create) do |shot, evaluator|
        create_list(:co_ordinate, evaluator.co_ordinates_count, :parent => shot)
      end
    end
  end
end