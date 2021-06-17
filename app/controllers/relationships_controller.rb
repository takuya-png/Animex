class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  respond_to? :js
  def create
    if logged_in?
      @user = User.find(params[:relationship][:followed_id])
      current_user.follow!(@user)
    end
  end

  def destroy
  end
end
