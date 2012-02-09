class PhotoController < ApplicationController
  before_filter :load_user
  def index
    @photos = @user.photos.paginate(:page => params[:page], :per_page => 12)
  end

  def show
  end

  def create
    @photo = Photo.new(params[:photo])
    @photo.user_id = params[:user_id]
    if @photo.save
      flash[:notice] = "Photo Added"
      redirect_to user_photo_index_path current_user
    else
      flash[:error] = "Error"
      redirect_to user_photo_index_path current_user
    end
  end

  def destroy
    Photo.find_by_id(params[:id]).destroy
    redirect_to user_photo_index_path current_user
  end

private
  def load_user
    @user = User.find_by_id(params[:id] || current_user.id)
  end
end
