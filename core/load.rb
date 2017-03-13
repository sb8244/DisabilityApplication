require "active_support/all"
require "active_model"

require_relative "./validator"

Dir[File.join(File.dirname(__FILE__), 'models', 'mixins', '*.rb')].each {|file| require file } # dependency on the mixins being available
Dir[File.join(File.dirname(__FILE__), 'models', '*.rb')].each {|file| require file } # There should be no class dependencies here
Dir[File.join(File.dirname(__FILE__), 'models', '**', '*.rb')].each {|file| require file } # There are class dependencies based on nesting

I18n.enforce_available_locales = false
