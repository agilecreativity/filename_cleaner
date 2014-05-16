# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "filename_cleaner/version"

Gem::Specification.new do |spec|
  spec.name          = "filename_cleaner"
  spec.version       = FilenameCleaner::VERSION
  spec.authors       = ["Burin Choomnuan"]
  spec.email         = ["agilecreativity@gmail.com"]
  spec.summary       = %q(Bulk rename/remove unwanted characters from list of files in any directory recursively)
  spec.description   = %q(
    Bulk rename and remove unwanted characters from list of files in any directory recursively.
    Turn something like 'my_#$@#$_bad_$!@_filename!!.txt' into 'my_bad_filename.txt'
  ).gsub(/^\s+/, " ")
  spec.homepage      = "https://github.com/agilecreativity/filename_cleaner"
  spec.license       = "MIT"
  spec.files         = Dir.glob("{bin,lib}/**/*") +
                                %w[Gemfile
                                   Rakefile
                                   filename_cleaner.gemspec
                                   README.md
                                   CHANGELOG.md
                                   LICENSE
                                   .rubocop.yml
                                   .gitignore]
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  spec.add_runtime_dependency "thor", "~> 0.19"
  spec.add_runtime_dependency "agile_utils", "~> 0.1"
  spec.add_runtime_dependency "code_lister", "~> 0.1"
  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake", "~> 10.1"
  spec.add_development_dependency "awesome_print", "~> 1.2"
  spec.add_development_dependency "minitest-spec-context", "~> 0.0.3"
  spec.add_development_dependency "guard-minitest", "~> 2.2"
  spec.add_development_dependency "minitest", "~> 5.3"
  spec.add_development_dependency "guard", "~> 2.6"
  spec.add_development_dependency "pry", "~> 0.9"
  spec.add_development_dependency "gem-ctags", "~> 1.0"
  spec.add_development_dependency "yard", "~> 0.8"
  spec.add_development_dependency "rubocop", "~> 0.20"
  spec.add_development_dependency "coveralls", "~> 0.7"
end
