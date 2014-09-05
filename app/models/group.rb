require_dependency "group"

class Group < Principal
  def active?
    true
  end
end
