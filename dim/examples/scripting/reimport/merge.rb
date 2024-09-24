$stdout.sync = true

require 'dim/loader'
require 'dim/commands/format'

# optional for testing, in real script the following line should be deleted
OPTIONS[:output_format] = 'extra'

puts 'Loading old...'
old_loader = Dim::Loader.new
old_loader.load(input_filenames: "#{File.dirname(__FILE__)}/old/config.dim", allow_missing: true)

puts 'Loading new...'
new_loader = Dim::Loader.new
new_loader.load(input_filenames: "#{File.dirname(__FILE__)}/new/config.dim", allow_missing: true)

if new_loader.requirements.any? { |_id, r| r.category != 'input' }
  puts 'Error: requirements with category != "input" loaded'
  exit(-1)
end

owned_by_us = %w[feature tags review_status comment]

new_loader.requirements.each do |id, r|
  next unless old_loader.requirements.key?(id)

  new_req = new_loader.original_data[r.filename]
  old_req = old_loader.original_data[old_loader.requirements[id].filename]

  owned_by_us.each do |elem|
    if old_req[id][elem] == '' # in original_data this means element was not specified
      new_req[id].delete(elem)
    else
      new_req[id][elem] = old_req[id][elem]
    end
  end

  # reset review_status if relevant customer field has been updated
  new_req[id]['review_status'] = 'auto' if %w[text asil].any? { |elem| old_req[id][elem] != new_req[id][elem] }
end

formatter = Dim::Format.new(new_loader)
formatter.execute
