STDOUT.sync = true

# get annotations from test cases
require_relative '../Rakefile.rb'
require 'json'
Dir.chdir("..") do
  $dry_run = true
  Rake.application['test:spec'].invoke()
end
f = File.read(File.dirname(__FILE__) + "/source/pages/requirements-generated/mapping.json")
refdReqs = JSON.parse(f)
testCases = {}
refdReqs.each do |id, tcs|
  tcs.each do |tc|
    testCases[tc["location"]] ||= []
    testCases[tc["location"]] << id if id != ""
  end
end

# get requirement IDs
require_relative '../../dim/lib/dim/loader.rb'
loader = Dim::Loader.new
loader.load(file: File.dirname(__FILE__) + "/../req/config.dim")
reqs = loader.requirements.values.select{|r| r.type == "requirement"}
reqIDs = reqs.map{|r| r.id}

# write mapping page
File.open(File.dirname(__FILE__) + "/source/pages/requirements-generated/mapping.rst", "w") do |f|
  f.puts "Test Case Mapping"
  f.puts "================="
  f.puts ""
  f.puts ".. list-table::"
  f.puts "    :width: 100%"
  f.puts "    :widths: 30 25 50"
  f.puts "    :header-rows: 1"
  f.puts ""
  f.puts "    * - Requirements ID"
  f.puts "      - Test Case Location"
  f.puts "      - Test Case Description"

  reqIDs.each do |r|
    f.puts "    * - :ref:`#{r} <#{r}>`"
    if refdReqs.include?(r)
      refdReqs[r].each_with_index do |data, i|
        f.puts "    * -" if i > 0
        f.puts "      - #{data["location"]}"
        f.puts "      - #{data["description"]}"
      end
    else
      f.puts "      - :red:`[missing]`"
      f.puts "      - :red:`[missing]`"
    end
  end
end

# write stats page
File.open(File.dirname(__FILE__) + "/source/pages/requirements-generated/stats.rst", "w") do |f|
  f.puts "Statistics"
  f.puts "=========="
  f.puts ""
  f.puts "Requirements"
  f.puts "------------"
  f.puts ""
  f.puts ".. list-table::"
  f.puts "    :width: 100%"
  f.puts "    :widths: 50 50"
  f.puts ""

  f.puts "    * - Total number of requirements"
  f.puts "      - #{reqs.length}"

  f.puts "    * - Valid requirements"
  f.puts "      - #{reqs.count{|r| r.status == "valid"}}"

  reqs_covered = reqs.select{|r| r.tags.uniq.include?("covered")}
  f.puts "    * - Covered requirements"
  f.puts "      - #{reqs_covered.length}"
  (reqs-reqs_covered).each do |r|
    f.puts "        |br|:red:`#{r.id}`"
  end

  reqs_tested = reqs.select{|r| r.tags.uniq.include?("tested")}
  f.puts "    * - Tested requirements"
  f.puts "      - #{reqs_tested.length}"
  (reqs-reqs_tested).each do |r|
    f.puts "        |br|:red:`#{r.id}`"
  end

  reqIDs_mapped = reqIDs.select{|r| refdReqs.has_key?(r)}
  f.puts "    * - Requirements mapped to test cases"
  f.puts "      - #{reqIDs_mapped.length}"
  (reqIDs-reqIDs_mapped).each do |id|
    f.puts "        |br|:red:`#{id}`"
  end
  f.puts ""

  f.puts "Test Cases"
  f.puts "----------"
  f.puts ""
  f.puts ".. list-table::"
  f.puts "    :width: 100%"
  f.puts "    :widths: 50 50"
  f.puts ""
  f.puts "    * - Total number of test cases"
  f.puts "      - #{testCases.length}"
  f.puts "    * - Test cases with valid requirement IDs"
  not_valid = testCases.select{|loc, ids| ids.any? {|id| !reqIDs.include?(id)}}
  f.puts "      - #{testCases.length - not_valid.length}"
  not_valid.each do |loc, ids|
    f.puts "        |br|:red:`#{loc}`"
  end
  invalid = testCases.select{|loc, ids| ids.any? {|id| !reqIDs.include?(id)}}
  f.puts "    * - Test cases without invalid requirement IDs"
  f.puts "      - #{testCases.length - invalid.length}"
  invalid.each do |loc, ids|
    f.puts "        |br|:red:`#{loc}`"
    ids.each do |id|
      f.puts "        |br|- :red:`#{id}`" if !reqIDs.include?(id)
    end
  end
end
