class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]
  def index
    @topics = Topic.all
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(topic_params)
    if @topic.save
      redirect_to topics_path, notice: '作成しました'
    else
      render :new
    end
  end

  def show
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
  private
  def topic_params
    params.require(:topic).permit(:title, :content, :image, :image_cache)
  end
  def set_topic
    @topic = Topic.find(params[:id])
  end
end
