require 'rails_helper'
RSpec.describe 'Admin', type: :system do

  let!(:user) { FactoryBot.create(:user) }
  let!(:user2) { FactoryBot.create(:user2) }
  let!(:topic2) { FactoryBot.create(:topic2, user_id:user2.id) }
  let!(:favorite) { FactoryBot.create(:favorite, topic_id:topic2.id, user_id:user.id) }
  let!(:comment) { FactoryBot.create(:comment, topic_id:topic2.id, user_id:user.id) }
  describe '管理者機能' do
    before do 
      visit root_path
      click_on "ログイン"
      click_on 'ゲスト管理者ログイン(閲覧用)'
      click_on '管理者画面へ'
    end
  
    context '管理者の場合,' do
      it '管理者ページにアクセスできて投稿の削除ができる。' do
        expect(current_path).to eq rails_admin_path
        find('.nav-pills').find_link('投稿').click
        find_by_id('list').find_by_id("bulk_form").find(".table-condensed").first('tr:nth-child(1) td:nth-child(9)').find(".list-inline").find_link('削除').click
        click_on('実行する')
        expect(page).to have_content '投稿の削除に成功しました'
      end
    end
    context '管理者の場合,' do
      it 'お気に入りを削除することができる。' do
        expect(current_path).to eq rails_admin_path
        find('.nav-pills').find_link('Favorite').click
        find_by_id('list').find_by_id("bulk_form").find(".table-condensed").first('tr:nth-child(1) td:nth-child(7)').find(".list-inline").find_link('削除').click
        click_on('実行する')
        expect(page).to have_content 'Favoriteの削除に成功しました'
      end
    end

    context '管理者の場合,' do
      it '管理者ページにアクセスできて投稿の編集ができる。' do
        expect(current_path).to eq rails_admin_path
        find('.nav-pills').find_link('投稿').click
        find_by_id('list').find_by_id("bulk_form").find(".table-condensed").first('tr:nth-child(1) td:nth-child(9)').find(".list-inline").find_link('編集').click
        find_by_id('topic_content').set "編集しましたよ〜〜〜"
        click_button '保存'
        expect(page).to have_content '投稿の更新に成功しました'
      end
    end

    context '管理者の場合,' do
      it '管理者ページにアクセスできてコメントの編集ができる。' do
        expect(current_path).to eq rails_admin_path
        find('.nav-pills').find_link('コメント').click
        find_by_id('list').find_by_id("bulk_form").find(".table-condensed").first('tr:nth-child(1) td:nth-child(9)').find(".list-inline").find_link('編集').click
        find_by_id('comment_content').set "編集しました"
        click_button '保存'
        expect(page).to have_content 'コメントの更新に成功しました'
      end
    end
  end
  describe '管理者ログイン' do
    before do
      visit root_path
    end
    context '管理者の場合,' do
      it '管理者ページにログインできる。' do
        click_on "ログイン"
        fill_in 'user[email]',with: 'takuya@docomo.ne.jp'
        fill_in 'user[password]', with: 'password'
        click_button 'commit'
        click_on '管理者画面'
        sleep(0.5)
        expect(page).to have_content 'サイト管理'
      end
    end
    context '管理者でない場合,' do
      it '管理者ページにはアクセスできない' do
        click_on "ログイン"
        fill_in 'user[email]',with: 'takuya2@docomo.ne.jp'
        fill_in 'user[password]', with: 'password2'
        click_button 'commit'
        expect(page).to have_no_content '管理者画面へ'
      end
    end
  end
end