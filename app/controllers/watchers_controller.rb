require_dependency "watchers_controller"

class WatchersController < ApplicationController
  def append
    user_ids = params[:watcher][:user_ids] || params[:watcher][:user_id]
    @users = Group.where(id: user_ids).all + User.active.where(id: user_ids).all

    render(nothing: true) if @users.blank?
  end

  def destroy
    @watched.set_watcher(User.where(id: params[:user_id]).first, false)
    @watched.set_watcher(Group.where(id: params[:user_id]).first, false)

    respond_to do |format|
      format.html { redirect_to :back }
      format.js
      format.api { render_api_ok }
    end
  end

  def users_for_new_watcher_with_groups
    users_for_new_watcher_without_groups.tap do |users|
      if @watched
        users.concat(Group.all.sorted - Group.where(id: @watched.watcher_users))
      else
        users.concat(Group.all.sorted)
      end
    end
  end
  alias_method_chain :users_for_new_watcher, :groups
end
