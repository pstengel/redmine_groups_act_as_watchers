require_dependency "watchers_controller"

class WatchersController < ApplicationController
  def append_with_groups
    user_ids = params[:watcher][:user_ids] || params[:watcher][:user_id]
    @users = Group.where(id: user_ids).all + User.active.where(id: user_ids).all

    render(nothing: true) if @users.blank?
  end
  alias_method_chain :append, :groups

  def destroy_with_groups
    @watched.set_watcher(User.where(id: params[:user_id]).first, false)
    @watched.set_watcher(Group.where(id: params[:user_id]).first, false)

    respond_to do |format|
      format.html { redirect_to :back }
      format.js
      format.api { render_api_ok }
    end
  end
  alias_method_chain :destroy, :groups

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
