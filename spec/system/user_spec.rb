require 'rails_helper'
RSpec.describe 'User関連機能',type: :system do
  let!(:user){create(:user)}
  before do
    visit root_path
  end
  describe 'devise関連機能' do
    context '全ての記述が正しい場合' do
      it 'サインアップできる' do
        click_on '新規登録'
        fill_in "user[name]", with: "永澤"
        fill_in "user[email]", with: "test@test.com"
        fill_in "user[password]", with: "password"
        fill_in "user[password_confirmation]", with: "password"
        sleep(0.5)
        click_button '新規登録'
        expect(current_path).to have_content '/'
        expect(page).to have_content '好きなアニメについて話したい人が交流できる場所'
      end
    end
    context '入力漏れが合った場合' do
      it 'サインアップできない' do
        click_on '新規登録'
        click_button 'commit'
        expect(current_path).to have_content '/users/sign_up'
      end
    end
    context '全ての記述が正しい場合' do
      it 'ログインできる' do
        click_on 'ログイン'
        fill_in 'user[email]',with: 'takuya@docomo.ne.jp'
        fill_in 'user[password]', with: 'password'
        click_button 'ログイン'
        expect(current_path).to have_content '/'
        expect(page).to have_content '好きなアニメについて話したい人が交流できる場所'
      end
    end
    context 'emailとpasswordが一致しない場合' do
      it 'ログインできない' do
        visit new_user_session_path
        fill_in 'user[email]',with: 'nagasawa@gmail.com'
        fill_in 'user[password]', with: 'ミスパスワード'
        click_button 'ログイン'
        expect(current_path).to have_content '/users/sign_in'
      end
    end
    describe 'ログイン後' do
      context 'ログアウトした場合' do
        it  'トップページに戻りログイン状態が解除される' do
          visit root_path
          visit new_user_session_path
          fill_in 'user[email]',with: 'takuya@docomo.ne.jp'
          fill_in 'user[password]', with: 'password'
          click_button 'ログイン'
          expect(page).to have_content 'Animex'
          sleep(0.5)
          click_on'ログアウト'
          expect(page).to have_content '好きなアニメについて話したい人が交流できる場所'
        end
      end
    end
    describe 'その他機能' do
        it 'フォロー一覧機能' do
          visit new_user_session_path
          fill_in 'user[email]',with: 'takuya@docomo.ne.jp'
          fill_in 'user[password]', with: 'password'
          click_button 'ログイン'
          click_on 'Topic一覧'
          click_on 'Myプロフィール'
          expect(page).to have_content 'Myプロフィール'
        end
        it 'ゲストログイン機能' do
          visit root_path
          click_on 'ゲストログイン(閲覧用)'
          expect(page).to have_content 'Topics'
          expect(page).to have_content 'タイトル'
          expect(page).to have_content 'タイトルor内容検索'
        end
        it 'ゲスト管理者ログイン機能' do
          visit root_path
          click_on 'ゲスト管理者ログイン(閲覧用)'
          expect(page).to have_content 'Topics'
          expect(page).to have_content 'タイトル'
          expect(page).to have_content 'タイトルor内容検索'
          expect(page).to have_content 'Topic一覧'
        end
    end
  end
end