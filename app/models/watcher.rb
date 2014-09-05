require "watcher"

class Watcher < ActiveRecord::Base
  belongs_to :user, :class_name => "Principal"
end
