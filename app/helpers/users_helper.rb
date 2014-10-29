module UsersHelper

  def add_comment_about(user)
    link_to "Yorum Yaz", new_comment_path(is_about: user.id), class: "btn btn-small", id: "write_comment"
  end

end
