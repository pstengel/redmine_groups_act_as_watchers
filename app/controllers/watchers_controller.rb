require_dependency "watchers_controller"

class WatchersController < ApplicationController
  def users_for_new_watcher_with_groups
    users_for_new_watcher_without_groups.tap do |users|
      if @watched
        users.concat(Group.all - Group.where(id: @watched.watcher_users))
      else
        users.concat(Group.all)
      end
    end
  end
  alias_method_chain :users_for_new_watcher, :groups
end
