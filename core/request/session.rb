class Session
  def initialize
    @authorized = false
  end

  def authorized?
    @authorized
  end

  def authorized!
    @authorized = true
    self
  end
end
