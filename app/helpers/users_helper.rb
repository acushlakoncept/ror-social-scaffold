module UsersHelper
    def invite_or_pending_btn(obj)
        return unless current_user.id != obj.id

        return if current_user.friend?(obj)

        if current_user.pending_friends.include?(obj)
            link_to('pending invite', '#')
        elsif current_user.friend_requests.include?(obj)
            link_to('Accept', invite_path(user_id: obj.id), method: :put)
        else
            link_to('Invite', invite_path(user_id: obj.id), method: :post)
        end
    end
end
