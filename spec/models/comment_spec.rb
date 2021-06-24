require 'rails_helper'
RSpec.describe Comment, type: :model do
  describe 'commentモデル機能' do
    context 'バリデーションテスト' do
      it 'コメントが空の場合' do
        user45 = create(:user45)
        topic33 = create(:topic33)
        comment = Comment.new(content: nil, user_id: user45.id, topic_id: topic33.id)
        expect(comment).to be_invalid
      end
    end
  end
end