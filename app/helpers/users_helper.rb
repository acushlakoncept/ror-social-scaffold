module UsersHelper
  def invite_or_pending_btn(obj)
    return unless current_user.id != obj.id

    return if current_user.friend?(obj)

    out = ''
    if current_user.pending_friends.include?(obj)
      out << link_to('pending friendship', '#', class: 'profile-link f-link')
    elsif current_user.friend_requests.include?(obj)
      out << link_to('Accept', invite_path(user_id: obj.id), class: 'profile-link f-link', method: :put)
      out << ' | '
      out << link_to('Reject', reject_path(user_id: obj.id), class: 'profile-link f-link', method: :delete)
    else
      out << link_to('Invite to friendship', invite_path(user_id: obj.id), class: 'profile-link f-link', method: :post)
    end

    out.html_safe
  end
end
