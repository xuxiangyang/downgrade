lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "downgrade/version"

Gem::Specification.new do |spec|
  spec.name          = "downgrade"
  spec.version       = Downgrade::VERSION
  spec.authors       = ["xxy"]
  spec.email         = ["xxy@xiangyang.com"]

  spec.summary       = "rails downgrade"
  spec.description   = "downgrade for rails in whole app、assign pathes、block level"
  spec.homepage      = "https://github.com/xuxiangyang/downgrade"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport", ">5.0"
  spec.add_dependency "redis", ">3.0"
  spec.add_dependency "rack", ">= 2.0.6"
  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
end
