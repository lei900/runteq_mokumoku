# frozen_string_literal: true

class Mypage::FollowRelationsController < Mypage::BaseController
  def following
    @title = 'フォロ中'
    @users = current_user.following.page(params[:page])
    render 'show'
  end

  def followers
    @title = 'フォロワー'
    @users = current_user.followers.page(params[:page])
    render 'show'
  end

  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
    respond_to do |format|
      format.html { redirect_to mypage_root_path }
      format.js
    end
  end

  def destroy
    relationship_id = current_user.active_relationships.
                        find_by(followed_id: params[:followed_id]).id
    @user = Relationship.find(relationship_id).followed
    current_user.unfollow(@user)
    respond_to do |format|
      format.html { redirect_to mypage_root_path }
      format.js
    end
  end
end
