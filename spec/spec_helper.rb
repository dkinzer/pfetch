# frozen_string_literal: true

require "pfetch"
require "webmock/rspec"

Dir[File.expand_path(File.join(File.dirname(__FILE__), "support", "**", "*.rb"))].sort.each { |f| require f }

def file_fixture(filename)
  File.read(File.join(File.dirname(__FILE__), "fixtures", filename.to_s))
end

RSpec.configure do |config|
  config.include Pfetch::StubResponse

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
