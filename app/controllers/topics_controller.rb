class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]
  before_action :set_q, only: [:index, :search]


  def index
    @topics = Topic.all
    # @favorite = current_user.favorites.find_by(topic_id: @topic.id)
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = current_user.topics.build(topic_params)
    if @topic.save
      redirect_to topics_path, notice: '作成しました'
    else
      render :new
    end
  end

  def show
    @favorite = current_user.favorites.find_by(topic_id: @topic.id)
    @comments = @topic.comments
    @comment = @topic.comments.build
  end

  def edit
  end

  def update
    if @topic.update(topic_params)
      redirect_to topics_path, notice: '編集しました'
    else
      render :new
    end
  end

  def destroy
    @topic.destroy
    redirect_to topics_path, notice: '削除しました'
  end

  def guest_sign_in
    user = User.find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  def search
    @results = @q.result
  end

  private

  def set_q
    @q = Topic.ransack(params[:q])
  end

  def topic_params
    params.require(:topic).permit(:title, :content, :image, :image_cache, :user_id)
  end

  def set_topic
    @topic = Topic.find(params[:id])
  end
end
