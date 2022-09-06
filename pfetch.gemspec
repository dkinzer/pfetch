# frozen_string_literal: true

require_relative "lib/pfetch/version"

Gem::Specification.new do |spec|
  spec.name = "pfetch"
  spec.version = Pfetch::VERSION
  spec.authors = ["David Kinzer"]
  spec.email = ["dtkinzer@gmail.com"]

  spec.summary = "Fetches combined results after querying multiple endpoints."
  spec.description = "Fetches combined results after querying multipel endpoints."
  spec.homepage = "https://github.com/dkinzer/pfetch"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0", "< 3.0.0"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.executables << "pfetch"
  spec.require_paths = ["lib"]

  spec.add_dependency "httparty", "~> 0.17"

  spec.add_development_dependency "pry", "0.14.1"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
