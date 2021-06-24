FactoryBot.define do
  factory :topic do
    title {'魔王学院の不適合者'}
    content {'アノス・ヴォルディゴード'}
  end
  factory :topic36,class: Topic do
    title {'進撃の巨人'}
    content {'リヴァイ兵長'}
    association :user, factory: :user45
  end
  factory :topic35,class: Topic do
    title {'東京喰種'}
    content {'金木研'}
    association :user, factory: :user45
  end
end