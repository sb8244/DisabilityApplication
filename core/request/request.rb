class Request
  NotAuthorizedError = Class.new(StandardError)

  def initialize(session:, params:)
    @session = session
    @params = params
    @response = Response.new
  end

  def call
    authorized!
    request
    response
  end

  private

  attr_reader :session, :params, :response

  def authorized!
    raise NotAuthorizedError unless session.authorized?
  end
end
