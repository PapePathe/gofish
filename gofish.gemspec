require_relative 'lib/gofish/version'

Gem::Specification.new do |spec|
  spec.name          = "gofish"
  spec.version       = Gofish::VERSION
  spec.authors       = ["Pathe SENE"]
  spec.email         = ["psene@boaholding.com"]

  spec.summary       = %q{GoFish Game}
  spec.description   = %q{Gofish Game Api}
  spec.homepage      = "https://andela.com"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "http://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://andela.com"
  spec.metadata["changelog_uri"] = "https://andela.com"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency :sinatra
  spec.add_dependency "sinatra-contrib"
  spec.add_dependency "rest-client"
  spec.add_development_dependency "rack-test"
  spec.add_development_dependency "json-schema"
  spec.add_development_dependency "guard-rspec"
end
