require_relative '../../../lib/dim/loader'
require '../../../lib/dim/requirement'
require '../../../lib/dim/commands/format'
require 'csv'

import_file_name = 'excel_export.csv'
export_file_name = 'SSR.dim'
module_name = 'CCP SSR'

mapping = {
  id: 'SSR ID',
  type: 'Object Type',
  text: 'Text',
  feature: 'Topic'
}

comments = ['Comments Person1', 'Comments Person2', 'Comments Person3']

file = File.read(import_file_name, encoding: 'bom|utf-8').encode(universal_newline: true)
table = CSV.parse(file, headers: true, col_sep: ';')

loader = Dim::Loader.new
loader.original_data[export_file_name] = {}
loader.original_data[export_file_name]['document'] = module_name

table.each do |row|
  data = { 'asil': 'ASIL_B' }

  if row['Object Type'] == 'Requirement'
    if row['Status']&.strip == 'Approved'
      data['status'] = 'valid'
      data['review_status'] = 'accepted'
    else
      data['status'] = 'draft'
      data['review_status'] = 'not_reviewed'
    end
  end

  data['comment'] = ''
  comments.each do |comment|
    next if row[comment].nil? || row[comment].empty?

    person = comment.sub('Comments ', '')
    data['comment'] = "#{data['comment']}#{person}: #{row[comment]}\n"
  end

  if row['Object Type'] == 'Heading'
    number = row['SSR ID'].scan(/[0-9]/).size
    row['Object Type'] = "#{row['Object Type']}_#{number}"
  end

  mapping.each do |key, value|
    next if key == :id
    next if row[value].nil?

    key == :type && row[value] && row[value].downcase!
    data[key.to_s] = row[value]
  end

  loader.original_data[export_file_name][row[mapping[:id]]] = data
end

formatter = Dim::Format.new(loader)

formatter.execute
