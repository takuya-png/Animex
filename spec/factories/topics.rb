FactoryBot.define do
  factory :topic do
    title {'魔王学院の不適合者'}
    content {'アノス・ヴォルディゴード'}
  end
  factory :topic2,class: Topic do
    title {'進撃の巨人'}
    content {'リヴァイ兵長'}
    association :user, factory: :user2
  end
  factory :topic3,class: Topic do
    title {'東京喰種'}
    content {'金木研'}
    association :user, factory: :user3
  end
end