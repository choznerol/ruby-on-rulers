
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "rulers/version"

Gem::Specification.new do |spec|
  spec.name          = "rulers"
  spec.version       = Rulers::VERSION
  spec.authors       = ["Lawrence Chou"]
  spec.email         = ["lawrencechou1024@gmail.com"]

  spec.summary       = %q{A Rack-based web framework from <Rebuilding Rails>}
  spec.description   = %q{A Rack-based web framework, built by following the book <Rebuilding Rails>}
  spec.homepage      = "https://github.com/choznerol/ruby-on-rulers"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = "https://github.com/choznerol/ruby-on-rulers"
    spec.metadata["changelog_uri"] = "https://github.com/choznerol/ruby-on-rulers/CHANGELOG.md"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry-byebug", "~> 3.7"
  spec.add_runtime_dependency "erubis", "~> 2.7"
  spec.add_runtime_dependency "rack", "~> 2.0"
  spec.add_runtime_dependency "json", "~> 2.2"
  spec.add_development_dependency "rack-test", "~> 1.1"
  spec.add_development_dependency "test-unit", "~> 3.3"
end
