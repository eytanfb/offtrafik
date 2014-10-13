module UsersHelper

  def add_comment_about(user)
    link_to "#{t 'users_helper.add_comment'}", new_comment_path(is_about: user.id), class: "btn btn-small", id: "write_comment"
  end

end
