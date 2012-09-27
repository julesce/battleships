FactoryGirl.define do
  factory :board, aliases: [:player_board] do
    game
    size 10
    type_of 'player'

    # Lets make a factory available with 5 shots
    factory :board_with_shots do
      ignore do
        shots_count 5
      end

      after(:create) do |board, evaluator|
        create_list(:shot, evaluator.shots_count, :board => board)
      end
    end
  end

  factory :opponent_board, :class => Board do
    game
    size 10
    type_of 'player'
  end


end