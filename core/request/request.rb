class Request
  NotAuthorizedError = Class.new(StandardError)

  def initialize(session:, params:)
    @session = session
    @params = params
  end

  private

  attr_reader :session, :params

  def authorized!
    raise NotAuthorizedError unless session.authorized?
  end
end
