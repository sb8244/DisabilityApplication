require_relative "../core/load"
require 'rspec/autorun'

Dir[File.join(File.dirname(__FILE__), 'core', 'factories', '*.rb')].each {|file| require file }

class TestAdapter
  def all
  end
end

$adapter_instance = TestAdapter.new

module TestAdapterMixin
  def test_adapter
    $adapter_instance
  end
end

class ProfessorQueries < ProfessorRepository::Queries
  def like_name(name)
    lambda { |r| r }
  end

  def like_email(email)
    lambda { |r| r }
  end
end

ProfessorRepository.set_adapter($adapter_instance)
ProfessorRepository.set_queries(ProfessorQueries.new)

RSpec.configure do |config|
  config.include TestAdapterMixin
  config.order = "random"
end
