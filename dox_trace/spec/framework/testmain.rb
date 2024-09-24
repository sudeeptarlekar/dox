require 'fileutils'

STDOUT.sync = true

puts "Deleting old test output"
Dir.glob("{spec/**/build,**/htmlcov,**/.coverage}").each do |f|
  FileUtils.rm_rf(f)
end

require 'rspec/core/rake_task'
SPEC_PATTERN ='spec/**/*_spec.rb'

namespace :test do
  desc "Run specs"
  RSpec::Core::RakeTask.new() do |t, args|
    t.pattern = SPEC_PATTERN
    t.rspec_opts = "--dry-run" if $dry_run
  end

  desc "Run specs with coverage"
  task :coverage do
    ENV['sphinx_coverage'] = "SPHINX_COVERAGE=1"
    task('test:spec').invoke("coverage")
    coverage_files = Dir.glob("spec/test_input/**/.coverage").join(" ")
    system("coverage combine --keep #{coverage_files}")
    system("coverage html")
    system("coverage report")
  end
end
