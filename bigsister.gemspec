lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "bigsister/version"

Gem::Specification.new do |spec|
  spec.name          = "bigsister"
  spec.version       = BigSister::VERSION
  spec.authors       = ["Paul Holden"]
  spec.email         = ["pholden@stria.com"]

  spec.summary       = %q{A gem for generating reports on the contents of local and remote files and folders.}
  spec.homepage      = "https://github.com/paulholden2/bigsister"
  spec.license       = "MIT"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/paulholden2/bigsister"
  spec.metadata["changelog_uri"] = "https://github.com/paulholden2/bigsister/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "springcm-sdk", "~> 0.3.2"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", ">= 12.3.3"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "simplecov", "~> 0.17"
end
