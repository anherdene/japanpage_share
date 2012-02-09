class HomeController < ApplicationController
  def index
    if user_signed_in?
      redirect_to user_path(:id => @current_user.id)
    end
  end

end
