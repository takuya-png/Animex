FactoryBot.define do
  factory :user do
    email {'takuya@docomo.ne.jp'}
    password {'password'}
    admin { true }
  end
  factory :user2 ,class: User do
    email {'takuya2@docomo.ne.jp'}
    password {'password2'}
    admin { false }
  end
end 