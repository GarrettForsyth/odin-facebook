module ApplicationHelper

  def title(page_title)
    content_for(:title) { page_title }
  end

  def current_user?(user)
    user == current_user
  end


  def gravatar_for(user, options = { size: 80 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size=options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end

  def thumb_for(user, options = { size: 100 })
    if user.avatar.exists? 
      image_tag user.avatar.url(:thumb)
    else
      gravatar_for(user, options)
    end
  end

end
