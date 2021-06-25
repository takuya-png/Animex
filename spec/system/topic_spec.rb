require 'rails_helper'
RSpec.describe '投稿管理機能', type: :system do
  let!(:user) {create(:user)}
  let!(:topic) {create(:topic,user_id: user.id)}
  let!(:topic2) {create(:topic2)}
  let!(:topic3) {create(:topic3)}
  # let!(:favorite){create(:favorite,topic_id: topic3.id, user_id: user.id)}

  before do
    visit root_path
    # binding.irb
    sleep(0.5)
    click_link 'ログイン'
    fill_in 'user[email]',with: 'takuya@docomo.ne.jp'
    fill_in 'user[password]',with: 'password'
    sleep(0.5)
    click_button 'ログイン'
    sleep(0.5)
    click_link 'Topic一覧'
  end

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        # binding.irb
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
        # binding.irb
        first('tr:nth-child(4) td:nth-child(7)').click
        # find('#favorite').click
        click_on 'お気に入り一覧'
        expect(current_path).to have_content "/favorites"
        expect(page).to have_content 'お気に入り一覧'
      end
    end
    context 'お気に入り解除した場合' do
      it 'お気に入り一覧に表示されなくなる' do
        # binding.irb
        first('tr:nth-child(4) td:nth-child(7)').click
        expect(page).to have_content '詳細'
        first('tr:nth-child(4) td:nth-child(7)').click
        click_on 'お気に入り一覧'
        expect(current_path).to have_content '/favorites'
        expect(page).not_to have_content '魔王学院の不適合者'
      end
    end
  end
  describe '投稿編集機能' do
    context '自分の投稿を編集する場合' do
      it '投稿が編集される' do
        # binding.irb
        first('tr:nth-child(3) td:nth-child(5)').click
        # find(".sid_content").click
        click_on '更新'
        expect(page).to have_content "タイトル"
        # fill_in "topic[タイトル]"
        # first('tr:nth-child(3) td:nth-child(4)').click
        # expect(page).to have_content "投稿詳細"
        # expect(page).to have_content "編集しましたよ"
        # sleep(0.5)
      end
    end
  end
  describe '投稿削除機能' do
    context '投稿を削除する場合' do
      it '投稿が削除できる' do
        # binding.irb
        first('tr:nth-child(2) td:nth-child(6)').click
        page.driver.browser.switch_to.alert.accept
        # click_on 'OK'
        # click_on '投稿削除'
        # page.driver.browser.switch_to.alert.accept
        # click_on 'Myプロフィール'
        expect(page).not_to have_content '魔王学院の不適合者'
      end
    end
  end
  describe 'トピック検索機能' do
    context 'トピック検索した場合' do
      it '該当の投稿が表示される' do
        binding.irb
        fill_in "q[title_or_content_cont]" ,with: '東京'
        click_button '検索'
        expect(page).to have_content '検索結果'
        expect(page).to have_content '熊本県天草市'
      end
    end
  end
end