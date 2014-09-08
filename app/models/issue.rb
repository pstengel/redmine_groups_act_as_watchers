require_dependency "issue"

class Issue < ActiveRecord::Base
  def notified_watchers_with_groups
    notified_watchers_without_groups.tap do |users|
      watcher_users.select { |u| u.type == "Group" }.each do |group|
        group_users = group.users.active.select do |user|
          (!user.mail.blank? && user.mail_notification != "none") &&
            (respond_to?(:visible?) && visible?(user))
        end

        users.concat group_users
      end
    end
  end
  alias_method_chain :notified_watchers, :groups

  def remove_watcher(user)
    return nil unless user && (user.is_a?(User) || user.is_a?(Group)
    watchers.where(:user_id => user.id).delete_all
  end
end
