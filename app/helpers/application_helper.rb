module ApplicationHelper

  def requests_num
    current_user.requests_num == 0 ? '' : '(' + current_user.requests_num.to_s + ')'
  end

end
