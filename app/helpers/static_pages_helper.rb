module StaticPagesHelper
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
  
  def featurette(title, content, image_link)
    "<h4>#{title}</h4>
    #{image_tag image_link}
    <p>#{content}</p>".html_safe
  end
end
