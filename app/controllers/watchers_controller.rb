require_dependency "watchers_controller"

class WatchersController < ApplicationController
  def users_for_new_watcher_with_groups
    users = users_for_new_watcher_without_groups
    users.concat(Group.all)
    users -= Group.where(id: @watched.watcher_users) if @watched
  end
  alias_method_chain :users_for_new_watcher, :groups
end
