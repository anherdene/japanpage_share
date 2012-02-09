class PeopleController < ApplicationController
  before_filter :authenticate_user!
  def index
    @user = current_user
    @users = User.all
    @friendships = User.friendships_hash(@users,@user.friendships_array)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

end
