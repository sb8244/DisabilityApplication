require "active_support/all"
require "active_model"

require_relative "./validator"

require_relative "./models/attribute_assignment"
require_relative "./models/validatable"
require_relative "./models/professor"
require_relative "./models/submission"

I18n.enforce_available_locales = false
