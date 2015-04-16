module ApplicationHelper
  def like_dislike_image_url(post)
    if current_user
      fist_bump =  post.fist_bumps.where(:user_id => current_user.id).first
      return (fist_bump.present? && fist_bump.is_like) ? "unlike.png" : "like.png"
    end   
    "like.png"
  end
  
  def custom_visible(post)
    return 'custom_visible' if post.user == current_user
  end

  def get_user_thumb_image(user)
    if user.avatar?
      image_tag(user.avatar_url(:thumb))
    else
      image_tag("user_icon.jpg")
    end
  end
end
