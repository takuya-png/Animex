user1 = User.create!(
  name: "拓也",
  email: "test@docomo.com",
  password: "password",
  admin: true,
)

user2 = User.create!(
  name: "将悟",
  email: "test2@docomo.com",
  password: "password",
)

user3 = User.create!(
  name: "陽一郎",
  email: "test3@docomo.com",
  password: "password",
)

user4 = User.create!(
  name: "里沙",
  email: "test4@docomo.com",
  password: "password",
)

user5 = User.create!(
  name: "諒",
  email: "test5@docomo.com",
  password: "password",
)

topic1_1 = Topic.create!(
  title: "ソードアートオンライン",
  content: "キリト△",
  image: File.open("app/assets/images/icon1.jpeg"),
  user_id: user1.id,
)
topic1_2 = Topic.create!(
  title: "七つの大罪",
  content: "メリオダス",
  image: File.open("app/assets/images/icon2.jpeg"),
  user_id: user1.id,
)
#------------

topic2_1 = Topic.create!(
  title: "東京喰種",
  content: "金木研",
  image: File.open("app/assets/images/icon3.jpeg"),
  user_id: user2.id,
)
topic2_2 = Topic.create!(
  title: "進撃の巨人",
  content: "リヴァイ兵長",
  image: File.open("app/assets/images/icon4.jpeg"),
  user_id: user2.id,
)

topic3_1 = Topic.create!(
  title: "クレイモア",
  content: "クレア",
  image: File.open("app/assets/images/icon5.jpeg"),
  user_id: user3.id,
)
topic3_2 = Topic.create!(
  title: "炎炎ノ消防隊",
  content: "アーサー",
  image: File.open("app/assets/images/icon6.jpeg"),
  user_id: user3.id,
)
topic4_1 = Topic.create!(
  title: "魔王学院の不適合者",
  content: "アノス・ヴォルディゴード",
  image: File.open("app/assets/images/icon7.jpeg"),
  user_id: user4.id,
)
topic4_2 = Topic.create!(
  title: "デュラララ!!",
  content: "Seiji Yagiri & Mika Harima",
  image: File.open("app/assets/images/icon8.jpeg"),
  user_id: user4.id,
)
topic5_1 = Topic.create!(
  title: "七つの大罪",
  content: "Undead Van",
  image: File.open("app/assets/images/20210124_icon9.jpeg"),
  user_id: user5.id,
)
topic5_2 = Topic.create!(
  title: "HELLSING",
  content: "Alucarod…逆から読むとDoraculaって知ってた？",
  image: File.open("app/assets/images/icon10.jpeg"),
  user_id: user5.id,
)
Favorite.create!(
  [
    # user1
    {user_id: user1.id, topic_id: topic2_1.id},
    {user_id: user1.id, topic_id: topic3_1.id},
    # user2
    {user_id: user2.id, topic_id: topic3_2.id},
    {user_id: user2.id, topic_id: topic4_1.id},
    # user3
    {user_id: user3.id, topic_id: topic4_2.id},
    {user_id: user3.id, topic_id: topic5_1.id},
    # user4
    {user_id: user4.id, topic_id: topic5_2.id},
    {user_id: user4.id, topic_id: topic1_1.id},
    # user5
    {user_id: user5.id, topic_id: topic1_1.id},
    {user_id: user5.id, topic_id: topic2_2.id},
  ]
)
# フォロー/フォロワー
Relationship.create!(
  [
    {follower_id: user1.id, followed_id: user2.id},
    {follower_id: user1.id, followed_id: user3.id},
    {follower_id: user1.id, followed_id: user5.id},
    {follower_id: user2.id, followed_id: user1.id},
    {follower_id: user2.id, followed_id: user4.id},
    {follower_id: user2.id, followed_id: user5.id},
    {follower_id: user3.id, followed_id: user1.id},
    {follower_id: user3.id, followed_id: user2.id},
    {follower_id: user3.id, followed_id: user5.id},
    {follower_id: user4.id, followed_id: user3.id},
    {follower_id: user4.id, followed_id: user5.id},
    {follower_id: user4.id, followed_id: user1.id},
    {follower_id: user5.id, followed_id: user3.id},
    {follower_id: user5.id, followed_id: user4.id},
    {follower_id: user5.id, followed_id: user1.id},
  ]
)