module UserHelper

  def user_info(user)
    {
      "Short info" => { "Birthday" => user.birthday,
                        "Interests" => user.interests},
      "Contacts"   => { "Country" => user.country,
                        "City" => user.city,
                        "Phone" => user.phone,
                        "Skype" => user.skype,
                        "Address" => user.address},
      "Education"  => { "School" => user.school,
                        "University" => user.university}
    }
  end

end
