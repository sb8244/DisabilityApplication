require "active_support/all"
require "active_model"

require_relative "./validator"

Dir[File.join(File.dirname(__FILE__), 'models', 'mixins', '*.rb')].each { |file| require file } # dependency on the mixins being available
Dir[File.join(File.dirname(__FILE__), 'models', '*.rb')].each { |file| require file } # There should be no class dependencies here
Dir[File.join(File.dirname(__FILE__), 'models', '**', '*.rb')].each { |file| require file } # There are class dependencies based on nesting

Dir[File.join(File.dirname(__FILE__), 'repository', 'repository.rb')].each { |file| require file }
Dir[File.join(File.dirname(__FILE__), 'repository', '**', '*.rb')].each { |file| require file }
Dir[File.join(File.dirname(__FILE__), 'request', '**', '*.rb')].each { |file| require file }
Dir[File.join(File.dirname(__FILE__), 'requests', '**', '*.rb')].each { |file| require file }

I18n.enforce_available_locales = false
