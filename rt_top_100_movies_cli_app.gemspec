# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "rt_top_100_movies_cli_app/version"

Gem::Specification.new do |spec|
  spec.name          = "rt_top_100_movies_cli_app"
  spec.version       = RtTop100MoviesCliApp::VERSION
  spec.authors       = ["daniellecroxton"]
  spec.email         = ["danikrist@gmail.com"]

  spec.summary       = %q{Top 100 Movies of All Time from Rotten Tomatoes}
  spec.description   = %q{View and learn more about Rotten Tomatoes Top 100 Movies of All Time}
  spec.homepage      = "https://github.com/daniellecroxton/rt_top_100_movies_2"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata['http://rubygems.org']
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against " \
  #     "public gem pushes."
  # end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry", '~> 0'
  spec.add_development_dependency "open-uri", '~> 0'

  spec.add_development_dependency "nokogiri", '~> 0'
end
