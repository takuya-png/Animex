class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new
  end

  def show
    @user = User.find(params[:id])
    @users = @user.topics.all
  end

  def edit
  end

  def following
    @user  = User.find(params[:id])
    @users = @user.following
    render 'show_following'
  end

  def followers
    @user  = User.find(params[:id])
    @users = @user.followers
    render 'show_follower'
  end


end
