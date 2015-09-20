# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "fluent-plugin-loadaverage"
  spec.version       = "0.0.1"
  spec.authors       = ["mogulla3"]
  spec.email         = ["hs.iarn3@gmail.com"]

  spec.summary       = %q{Fluent input plugin to collect load average via uptime command.}
  spec.description   = %q{Fluent input plugin to collect load average via uptime command.}
  spec.homepage      = "https://github.com/mogulla3/fluent-plugin-loadaverage"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "fluentd"
  spec.add_development_dependency "rake"
end
