module ApplicationHelper

  def title(page_title)
    content_for(:title) { page_title }
  end

  def current_user?(user)
    user == current_user
  end

end
