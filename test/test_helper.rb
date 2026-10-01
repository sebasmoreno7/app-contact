ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Generated placeholder fixtures are incomplete; tests create the records they need.

  # Add more helper methods to be used by all tests here...
end
