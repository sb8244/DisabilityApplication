module AuthHelper
  def http_login
    user = ENV['HTTP_AUTH_NAME']
    pw = ENV['HTTP_AUTH_PASSWORD']
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)
  end  
end