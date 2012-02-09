class UserController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_user
  def show
    @posts = @user.posts.order("created_at desc").paginate(:page => params[:page], :per_page => 10)
  end

  def edit
    redirect_to user_path(:id => params[:id]) if params[:id] != current_user.id.to_s
  end

  def update
    #binding.pry
    @user.update_attributes(params[:user])
    respond_to do |format|
      format.js do
        render :js => "alert(OK);"
      end
      format.html { redirect_to edit_user_path(@user.id)}
    end
  end

private
  def load_user
    @user = User.find_by_id(params[:id] || current_user.id)
  end
end
