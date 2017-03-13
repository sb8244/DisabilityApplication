require "active_support/all"
require "active_model"

require_relative "./validator"

Dir[File.join(File.dirname(__FILE__), 'models', 'mixins', '*.rb')].each {|file| require file }
Dir[File.join(File.dirname(__FILE__), 'models', '*.rb')].each {|file| require file }

I18n.enforce_available_locales = false
