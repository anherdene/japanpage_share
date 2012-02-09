class FriendshipController < ApplicationController
  before_filter :authenticate_user!
  def index
    @user = User.find_by_id(params[:user_id])
    @requests = @user.friendship_requests
    @wanted = @user.wanted_friendships
    @friendships = @user.all_friendships
  end

  def create
    @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
    @friendship.is_confirmed = nil
    if @friendship.save
      flash[:notice] = 'Friend Added'
      redirect_to user_friendship_index_path current_user
    else
      flash[:error] = 'Failed to Add Friend'
      redirect_to user_friendship_index_path current_user
    end
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    if current_user.id == @friendship.user_id or current_user.id == @friendship.friend_id
      @friendship.destroy
      flash[:notice] = 'Friend Removed'
    end
    redirect_to user_friendship_index_path current_user
  end

  def confirm
    friendship = Friendship.where("id = ?", params[:id]).first!
    friendship.is_confirmed = true
    friendship.save
    redirect_to user_friendship_index_path current_user
  end

end
