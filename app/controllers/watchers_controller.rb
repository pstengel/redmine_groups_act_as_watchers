require_dependency "watchers_controller"

class WatchersController < ApplicationController
  def append_with_groups
    append_without_groups

    user_ids = params[:watcher][:user_ids] || params[:watcher][:user_id]
    @users += Group.where(id: user_ids).all

    render(nothing: true) if @users.blank?
  end
  alias_method_chain :append, :groups

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
