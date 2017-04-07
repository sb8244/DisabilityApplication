class Response
  ERROR_STATUSES = [:invalid_data, :not_found]
  SUCCESS_STATUSES = [:success]

  attr_accessor :view
  attr_reader :error_reason, :status

  def initialize
    @status = :success
    @view = nil
    @error_reason = nil
  end

  def success?
    SUCCESS_STATUSES.include?(@status)
  end

  def error?
    ERROR_STATUSES.include?(@status)
  end

  def set_error(type:, reason: nil)
    raise ArgumentError.new("type is not valid") unless ERROR_STATUSES.include?(type)
    @status = type
    @error_reason = reason
    self
  end
end
