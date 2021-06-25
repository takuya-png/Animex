require 'rails_helper'
RSpec.describe '投稿管理機能', type: :system do
  let!(:user) {create(:user)}
  let!(:topic) {create(:topic,user_id: user.id)}
  let!(:topic2) {create(:topic2)}
  let!(:topic3) {create(:topic3)}
  let!(:favorite){create(:favorite,topic_id: topic3.id, user_id: user.id)}

  before do
    visit root_path
    click_link 'ログイン'
    fill_in 'user[email]',with: 'takuya@docomo.ne.jp'
    fill_in 'user[password]',with: 'password'
    click_button 'ログイン'
  end

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        click_link '新規投稿'
        expect(current_path).to have_content '/topics/new'
        fill_in 'タイトル',with: '確認用タイトル'
        fill_in 'コンテンツ', with: '確認用コンテント'
        sleep(0.5)
        click_button '投稿'
        expect(page).to have_content '確認用タイトル'
        expect(page).to have_content '確認用コンテント'
        sleep(0.5)
      end
    end
    context 'タスク作成に失敗した場合' do
      it '画面遷移せずそのまま新規投稿画面にいること' do
        click_link '新規投稿'
        click_button 'commit'
        expect(current_path).to have_content '/topics'
      end
    end
  end
  describe 'お気に入り登録機能' do
    context 'お気に入りした場合' do
      it 'お気に入り一覧に表示される' do
        click_link 'スカイツリー'
        find('#favorite').click
        click_on 'お気に入り一覧'
        expect(current_path).to have_content "/favorites"
        expect(page).to have_content 'スカイツリー'
      end
    end
    context 'お気に入り解除した場合' do
      it 'お気に入り一覧に表示されなくなる' do
        click_link '北海道'
        expect(page).to have_content '投稿詳細'
        find('#unfavorite').click
        click_on 'お気に入り一覧'
        expect(current_path).to have_content '/favorites'
        expect(page).not_to have_content '北海道'
      end
    end
  end
  describe '投稿編集機能' do
    context '自分の投稿を編集する場合' do
      it '投稿が編集される' do
        click_on 'Myプロフィール'
        find(".sid_content").click
        click_link '投稿編集'
        expect(page).to have_content "投稿編集"
        fill_in "topic[title]", with: '編集しましたよ'
        click_on 'commit'
        expect(page).to have_content "投稿詳細"
        expect(page).to have_content "編集しましたよ"
        sleep(0.5)
      end
    end
  end
  describe '投稿削除機能' do
    context '投稿を削除する場合' do
      it '投稿が削除できる' do
        click_on 'Myプロフィール'
        click_on '阿蘇山'
        click_on '投稿削除'
        page.driver.browser.switch_to.alert.accept
        click_on 'Myプロフィール'
        expect(page).not_to have_content '阿蘇山'
      end
    end
  end
  describe '住所検索機能' do
    context '住所検索した場合' do
      it '該当の投稿が表示される' do
        fill_in "q[address_cont]" ,with: '熊本県'
        click_button 'commit'
        expect(page).to have_content '検索結果'
        expect(page).to have_content '熊本県天草市'
      end
    end
  end
end