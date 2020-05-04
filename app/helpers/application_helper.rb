module ApplicationHelper
  def menu_link_to(link_text, link_path)
    class_name = current_page?(link_path) ? 'menu-item active' : 'menu-item'

    content_tag(:div, class: class_name) do
      link_to link_text, link_path
    end
  end

  def like_or_dislike_btn(post)
    like = Like.find_by(post: post, user: current_user)
    if like
      link_to('Dislike!', post_like_path(id: like.id, post_id: post.id), method: :delete)
    else
      link_to('Like!', post_likes_path(post_id: post.id), method: :post)
    end
  end

  def friendship_decision(user)
    if current_user.pending_friends.include?(user)
      'PENDING'
    elsif current_user.friend_requests.include?(user)
      link_to('<button>ACCEPT</button>'.html_safe, accept_friend_path(id: user.id)) +
        ' ' +
        link_to('<button>DECLINE</button>'.html_safe, decline_friend_path(id: user.id))
    elsif user != current_user && current_user.friend?(user) == false
      link_to('request', friend_request_path(id: user.id), class: 'btn btn-secondary')
    end
  end
end
