require "redmine"

plugin = Redmine::Plugin.register :redmine_groups_act_as_watchers do
  name "Groups Act As Watchers"
  author "Paul Stengel"
  description "Give groups the ability to be added as watchers"
  version "0.0.1"
  url "http://github.com/pstengel/redmine_groups_act_as_watchers"
  author_url "http://www.5ops.com"
end

Rails.configuration.to_prepare do
  require "#{plugin.directory}/app/models/group"
  require "#{plugin.directory}/app/models/issue"
  require "#{plugin.directory}/app/models/watcher"
  require "#{plugin.directory}/app/controllers/watchers_controller"
end
