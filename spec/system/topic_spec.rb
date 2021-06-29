require 'rails_helper'
RSpec.describe '投稿管理機能', type: :system do
  let!(:user) {create(:user)}
  let!(:topic) {create(:topic,user_id: user.id)}
  let!(:topic2) {create(:topic2)}
  # let!(:topic3) {create(:topic3)}
  # let!(:favorite){create(:favorite,topic_id: topic3.id, user_id: user.id)}

  before do
    visit new_user_session_path
    sleep(0.1)
    fill_in 'user[email]',with: 'takuya@docomo.ne.jp'
    fill_in 'user[password]',with: 'password'
    click_button 'ログイン'
    sleep(0.1)
    click_link 'Topic一覧'
    sleep(0.1)
  end

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        sleep(0.1)
        click_link '新規投稿'
        sleep(0.1)
        expect(current_path).to have_content '/topics/new'
        fill_in 'タイトル',with: '確認用タイトル'
        fill_in 'コンテンツ', with: '確認用コンテント'
        click_button '投稿'
        sleep(0.1)
        expect(page).to have_content '確認用タイトル'
        expect(page).to have_content '確認用コンテント'
      end
    end
    context 'タスク作成に失敗した場合' do
      it '画面遷移せずそのまま新規投稿画面にいること' do
        sleep(0.1)
        click_link '新規投稿'
        sleep(0.1)
        click_button 'commit'
        sleep(0.1)
        expect(current_path).to have_content '/topics'
      end
    end
  end
  describe 'お気に入り登録機能' do
    context 'お気に入りした場合' do
      it 'お気に入り一覧に表示される' do
        first('tr:nth-child(2) td:nth-child(5)').click
        # find('#favorite').click
        click_on 'お気に入り一覧'
        sleep(0.1)
        expect(current_path).to have_content "/favorites"
        expect(page).to have_content 'お気に入り一覧'
      end
    end
    context 'お気に入り解除した場合' do
      it 'お気に入り一覧に表示されなくなる' do
        sleep(0.1)
        first('tr:nth-child(3) td:nth-child(5)').click
        expect(page).to have_content '詳細'
        first('tr:nth-child(3) td:nth-child(5)').click
        click_on 'お気に入り一覧'
        sleep(0.1)
        expect(current_path).to have_content '/favorites'
        expect(page).not_to have_content '魔王学院の不適合者'
      end
    end
  end
  describe '投稿編集機能' do
    context '自分の投稿を編集する場合' do
      it '投稿が編集される' do
        find_by_id("topics-index_row-#{topic.id}_edit").click
        title = 'タイトル'
        content = 'コンテンツ'
        fill_in title, with: '確認用タイトル'
        fill_in content, with: '確認用コンテント'
        click_on '更新'
        sleep(0.1)
        expect(find_by_id("topics-index_row-#{topic.id}_title")).to have_content title
      end
    end
  end
  describe '投稿削除機能' do
    context '投稿を削除する場合' do
      it '投稿が削除できる' do
        topic = Topic.last
        page.accept_confirm do
          click_on "削除"
        end
        # page.driver.browser.switch_to.alert.accept
        expect(page).not_to have_content '魔王学院の不適合者'
      end
    end
  end
  describe 'トピック検索機能' do
    context 'トピック検索した場合' do
      it '該当の投稿が表示される' do
        sleep(0.1)
        fill_in "q[title_or_content_cont]" ,with: topic2.title
        click_button '検索'
        sleep(0.1)
        lists = all(".topics-index_row")
        node = find_by_id("topics-index_row-#{topic2.id}")
        expect(lists.length).to eq 1
        expect(node).to be_present
      end
    end
  end
end