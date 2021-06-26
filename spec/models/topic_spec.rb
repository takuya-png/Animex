require 'rails_helper'
describe 'topicモデル機能', type: :model do
  before do
    @user = FactoryBot.create(:user)
  end

  describe 'バリデーションテスト' do
    context 'タイトルの入力が正しい場合' do
      it '新規作成ができる' do
        topic = Topic.new(title: 'aaa',
                          content: 'aaa',
                          image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/icon10.jpg')),
                          user_id: @user.id)
        expect(topic).not_to be_invalid
      end
    end
    context 'タイトルが空の場合' do
      it 'バリデーションエラーとなる' do
        topic = Topic.new(title: '',
                          content: 'aaa',
                          image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/icon10.jpg')),
                          user_id: @user.id)
        expect(topic).not_to be_valid
      end
    end
    context 'タイトルが51文字以上の場合' do
      it 'バリデーションエラーとなる' do
        topic = Topic.new(title: 'a'*51,
                          content: 'aaa',
                          image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/icon10.jpg')),
                          user_id: @user.id)
        expect(topic).to be_invalid
      end
    end
    context 'コンテントの入力が正しい場合' do
      it '新規作成できる' do
        topic = Topic.new(title: 'a',
                          content: 'aaa',
                          image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/icon10.jpg')),
                          user_id: @user.id)
        expect(topic).to be_valid
      end
    end
    context 'コンテントが空の場合' do
      it 'バリデーションエラーとなる' do
        topic = Topic.new(title: 'aaa',
                          content: '',
                          image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/icon10.jpg')),
                          user_id: @user.id)
        expect(topic).to be_invalid
      end
    end
    context 'コンテントが301文字以上の場合' do
      it 'バリデーションエラーとなる' do
        topic = Topic.new(title: 'aaa',
                          content: 'a'*301,
                          image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/icon10.jpg')),
                          user_id: @user.id)
        expect(topic).to be_invalid
      end
    end
  end
end