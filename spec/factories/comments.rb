FactoryBot.define do
  factory :comment do
    content { "MyString" }
  end
  factory :comment2, class: 'Comment' do
    content { "YEAR" }
    association :topic, factory: :topic
    user_id { (User.find_by(email: FactoryBot.build(:user2).email) || FactoryBot.create(:user2)).id }
  end
  factory :comment3, class: 'Comment' do
    content { "MyString2" }
    association :topic, factory: :topic2
    user_id { (User.find_by(email: FactoryBot.build(:user).email) || FactoryBot.create(:user)).id }
  end
  factory :comment4, class: 'Comment' do
    content { "YEAR2" }
    association :topic, factory: :topic2
    user_id { (User.find_by(email: FactoryBot.build(:user2).email) || FactoryBot.create(:user2)).id }
  end
end