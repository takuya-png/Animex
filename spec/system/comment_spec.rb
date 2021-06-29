require 'rails_helper'
RSpec.describe 'Topic管理機能', type: :system do
  let!(:user) {create(:user)}
  let!(:topic) {create(:topic,user_id: user.id)}
  let!(:topic2) {create(:topic2)}
  let!(:topic3) {create(:topic3)}

  before do
    visit new_user_session_path
    click_link 'ログイン'
    fill_in 'user[email]',with: 'takuya@docomo.ne.jp'
    fill_in 'user[password]',with: 'password'
    click_button 'ログイン'
  end

  describe 'Topicのコメント機能' do
    context 'Topicコメントでコメントを投稿した場合' do
      it '投稿したコメントが表示される' do
        click_on 'Topic一覧'
        # binding.irb
        click_on '詳細', match: :first
        expect(page).to have_content "Topic詳細"
        fill_in'comment[content]', with: 'ありがとうね！'
        attach_file 'comment[image]', 'app/assets/images/icon1.jpg'
        click_on '登録する'
        expect(page).to have_content "ありがとうね！"
      end
    end
  end
  describe 'コメント編集機能' do
    context '自分のコメントを編集する場合' do
      it 'コメントが編集される' do
        click_on 'Topic一覧'
        click_on '詳細', match: :first
        expect(page).to have_content "Topic詳細"
        fill_in'comment[content]', with: 'ありがとうね！'
        attach_file 'comment[image]', 'app/assets/images/icon1.jpg'
        click_on 'commit'
        click_on 'コメント編集'
        fill_in 'comment[content]',match: :first, with: ''
        fill_in 'comment[content]',match: :first, with: 'ありがとう、まじで！'
        click_on '更新する'
        # binding.irb
        expect(page).to have_content "コメントが編集されました"
      end
    end
  end
  describe 'コメント削除機能' do
    context 'コメントを削除する場合' do
      it 'コメントが削除できる' do
        click_on 'Topic一覧'
        click_on '詳細', match: :first
        expect(page).to have_content "Topic詳細"
        fill_in'comment[content]', with: 'ありがとうね！'
        attach_file 'comment[image]', 'app/assets/images/icon1.jpg'
        click_on 'commit'
        click_on 'コメント削除'
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content "コメントが削除されました"
      end
    end
  end
end