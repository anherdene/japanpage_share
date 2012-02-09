class PostController < ApplicationController

  def show
  end

  def create
    @post =Post.create :message => params[:post][:message],
                       :recepient_id => params[:user_id],
                       :sender_id => current_user.id
    flash[:notice] = "Post added!"
    respond_to do |format|
      format.js
      format.html{ redirect_to user_path(params[:user_id])}
    end
  end

  def destroy
    self.destroy
    respond_to do |format|
      format.js
      format.html{ redirect_to user_path(params[:user_id])}
    end
  end
end
