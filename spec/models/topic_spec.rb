require 'rails_helper'
describe 'topicモデル機能', type: :model do
  let!(:user) {create(:user)}
  let!(:topic) {create(:topic, user_id: user.id)}

  describe 'バリデーションテスト' do
    context 'タイトルの入力が正しい場合' do
      it '新規作成ができる' do
        expect(topic).to be_valid
      end
    end
    context 'タイトルが空の場合' do
      it 'バリデーションエラーとなる' do
        topic.title = nil
        expect(topic).to be_invalid
      end
    end
    context 'タイトルが51文字以上の場合' do
      it 'バリデーションエラーとなる' do
        topic.title = 'a'*51
        expect(topic).to be_invalid
      end
    end
    context 'コンテントの入力が正しい場合' do
      it '新規作成できる' do
        expect(topic).to be_valid
      end
    end
    context 'コンテントが空の場合' do
      it 'バリデーションエラーとなる' do
        topic.content= nil
        expect(topic).to be_invalid
      end
    end
    context 'コンテントが301文字以上の場合' do
      it 'バリデーションエラーとなる' do
        topic.content = 'a'*301
        expect(topic).to be_invalid
      end
    end
  end
end