FactoryBot.define do
  factory :user do
    name {'takuya1'}
    email {'takuya@docomo.ne.jp'}
    password {'password'}
    admin { true }
  end
  factory :user2 ,class: User do
    name {'takuya2'}
    email {'takuya2@docomo.ne.jp'}
    password {'password2'}
    admin { false }
  end
  factory :user3 ,class: User do
    name {'takuya3'}
    email {'takuya3@docomo.ne.jp'}
    password {'password3'}
    admin {false}
  end
end 