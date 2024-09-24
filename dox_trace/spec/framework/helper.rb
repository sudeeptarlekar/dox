
require 'json'
require 'fileutils'
require 'timeout'

require_relative '../../../dim/lib/dim/loader.rb'

$test_input_dir  = "spec/test_input"

module Sphinx
  class Test
    attr_reader :test_stdout, :test_stderr, :exit_code

    def initialize(testName, options = "")
      @testName = testName
      @options = options

      @test_stdout = ""
      @test_stderr = ""
      @exit_code = 255
    end

    def closeFd(fd)
      begin
        fd.close
      rescue Exception
      end
    end

    def killProcess(pid)
      begin
        5.times do |i|
          Process.kill("TERM", pid)
          sleep(1)
          break unless Process.waitpid(pid, Process::WNOHANG).nil? # nil = process still running
        end
        rescue Exception
        end
        begin
          Process.kill("KILL",pid)
        rescue Exception
        end
    end

    def run()
      begin
        rd_out, wr_out = IO.pipe
        rd_err, wr_err = IO.pipe
        pid = nil
        Timeout::timeout(60) do
          sphinxCoverage = ENV['sphinx_coverage'] || ''
          pid = spawn("make html -C #{$test_input_dir}/#{@testName} #{sphinxCoverage} #{@options}", :err=>wr_err, :out=>wr_out)
          closeFd(wr_out)
          closeFd(wr_err)
          pid, status = Process.wait2 pid
          if status.nil?
            puts "Process returned with unknown exit status"
            return
          end
          @test_stdout = rd_out.read()
          @test_stderr = rd_err.read()
          @exit_code = status.exitstatus
        end
      rescue Timeout::Error
        closeFd(rd_out)
        closeFd(rd_err)
        killProcess(pid)
      end
    end

    def dim_original_data()
      configSrc = "#{$test_input_dir}/config.dim"
      configDst = "#{$test_input_dir}/#{@testName}/export_root/config.dim"
      FileUtils.cp(configSrc, configDst)

      attrSrc = "#{$test_input_dir}/#{@testName}/attributes.dim"
      attrDst = "#{$test_input_dir}/#{@testName}/export_root/attributes.dim"
      if File.exist?(attrSrc)
        FileUtils.cp(attrSrc, attrDst)
        content = File.read(configDst)
        content << "Attributes: attributes.dim\n"
        File.write(configDst, content)
      end

      loader = Dim::Loader.new
      loader.load(file: configDst)
      return loader.original_data
    end
  end
end

class HtmlData
  attr_accessor :html

  def initialize(testName, relPath)
    @html = File.read("spec/test_input/#{testName}/build/html/#{relPath}")
  end

  def format_attribute(attribute)
    if attribute == "content"
      attribute = "<tr class=\"row-even\"><td><p>"
    else
      attribute = attribute.gsub("_", " ").split.map(&:capitalize).join(' ')
      attribute = "<strong>#{attribute}:</strong> "
    end
    return attribute
  end

  def getSpecInternal(id)

    pos_id_start = @html.index("id=\"#{id.downcase}\"")
    return nil if !pos_id_start
    pos_id_end = @html.index("</table>", pos_id_start)
    return nil if !pos_id_end

    return @html[pos_id_start..pos_id_end]
  end

  def getTableInternal(id, attribute)
    attribute = format_attribute(attribute)

    pos_id_start = @html.index("id=\"#{id.downcase}\"")
    return nil if !pos_id_start
    pos_id_end = @html.index("</table>", pos_id_start)

    pos_attribute = @html.index(attribute, pos_id_start)
    return nil if !pos_id_end || !pos_attribute || pos_attribute > pos_id_end
    return @html[pos_attribute+attribute.length..pos_id_end]
  end

  def value(id, attribute, link_text = false)
    table = getTableInternal(id, attribute)
    return nil if !table

    if attribute.downcase == "content"
      res = table.match(/(.*)<\/p><\/td><\/tr>\s*<tr class="row-odd/m)
      if res
        res_inner = res[1].match(/\A\s*<span[^>]*>(.+?)<\/span>/)
        return res_inner[1].strip if res_inner
        return res[1].strip
      end
      return nil
    end
    line = table.split("<br>")[0].split("<p>")[0]
    line = "" if !line

    if ["SRS_Requirement_VcSet", "SRS_Srs_VcSet"].include?(id)
      res = line.scan(/<span>(.*)<a .*href="([^"]+).*<\/a>(.*)<\/span>/)
      return res.join() if !res.empty?
    end

    if link_text
      res = line.scan(/">([^>]+)<\/span><\/a>/)
    else
      res = line.scan(/href="([^"]+)/)
    end
    return res.join(", ") if !res.empty?

    res = table.match(/\A\s*<div class="raw-html">(.*)<\/div>/)
    return res[1].strip if res

    # attributes in this test usually start with:
    # - start of line
    # - </span>
    # - <span ...>
    # attributes in this test usually end with:
    # - </span>
    # - <br>EOL
    # - |
    # - <br></span>
    # - <span
    # - end of line
    regex = "\\A\\s*(</span>)*(<span[^>]*>)*(.*?)(</span>|<br>$|<br>\\n| \\||<br></span>|<span)"
    if attribute.downcase == "custom_complex_text"
      res = table.match(/#{regex}/m)
    else
      res = table.match(/#{regex}/)
    end
    return res[3].strip if res

    res = table.match(/\A([^<|]+)/m)
    return res[1].strip if res

    return nil
  end

  def exist?(id, attribute)
    return getTableInternal(id, attribute) != nil
  end

  def as_is_line(id, attribute)
    getTableInternal(id, attribute).split("<br>").first
  end

  def red?(id, attribute)
    table = getTableInternal(id, attribute)
    return nil if !table
    return table.match(/\A\s*(<\/span><span>)*(<span class="dox-trace-grey">)*<span class="dox-trace-red">/m) != nil
  end

  def empty_class?(id, attribute)
    formatted_attribute = format_attribute(attribute)
    spec = getSpecInternal(id)
    return nil if !spec
    return spec.match(/dox-trace-attribute-empty">[ \|]*#{formatted_attribute}/) != nil
  end

  def missing_class?(id, attribute)
    formatted_attribute = format_attribute(attribute)
    spec = getSpecInternal(id)
    return nil if !spec
    return spec.match(/dox-trace-attribute-missing">[ \|]*#{formatted_attribute}/m) != nil
  end

  def struck?(id)
    pos_id_start = @html.index("id=\"#{id.downcase}\"")
    return nil if !pos_id_start
    pos_id_end = @html.index("</table>", pos_id_start)
    return @html[pos_id_end+8..-1].match(/\A\s*<div class="dox-trace-initially-hidden dox-trace-strikethrough-table">/m) != nil
  end

  # traceability report tables

  def tr_getSection(name)
     return @html.match(/<h\d>#{name}(.*?)\n(.*?)\n<\/section>/m)[2]
  end

  def tr_nodata?(name)
    section = tr_getSection(name)
    return section.include?("No data yet") && !section.include?("table")
  end

  def tr_desc(name)
    section = tr_getSection(name)
    line = section.split("\n", 2)[0]
    return line.gsub('<span class="raw-html"></br></span>', '|br|').gsub(/<\/*p>/, "")
  end

  def tr_values(name)
    section = tr_getSection(name)
    body = section.split("<tbody>")[1]
    rows = body.split("<tr class=")[1..-1]

    attr_values = section.scan(/<th class="head"><p>(.*?)<\/p><\/th>/).map{|h| h[0]}.select{|a| !a.empty?}
    mods = rows.map {|r| r.match(/"row-(even|odd)"><td>(.*?)<\/td>/)[2].gsub("<wbr>", "")}
    values = body.scan(/(>(\d+)<\/a>|<td>(0)<\/td>)/).map {|a| a[1].nil? ? a[2] : a[1] }
    refs = body.scan(/^<a href="[^"]+">(.+?)<\/a><[\/brp]+>$/).flatten

    result = {}
    total_v = 0
    mods.each_with_index do |m, m_ind|
      result[m] = {}
      attr_values.each_with_index do |a, a_ind|
        v = Integer(values[m_ind * attr_values.length + a_ind])
        result[m][a] = refs[total_v, v]
        total_v += v
      end
    end
    return result
  end

  def tr_list(name)
    section = tr_getSection(name)
    body = section.split("<tbody>")[1]
    rows = body.split("<tr class=")[1..-1]
    attr_values = ["mod"] + section.scan(/<th class="head"><p>(.*?)<\/p><\/th>/).map{|h| h[0]}.select{|a| !a.empty?}

    result = []
    rows.each do |r|
      values = []
      r.split("<td>")[1..-1].each do |col|
        col.gsub!(",<br>", ", ")
        col.gsub!("<wbr>", "")
        refs = col.scan(/(">|<span class="dox-trace-red">)(.+?)(<\/span>|<\/a>)/)
        if refs.length > 0
          v = refs.map{|r| r[1]}.join(", ")
          # needed if refs and sources/locations are specified
          additionals = col.match(/<\/span>([^<>]+?)<\/td>/)
          v << additionals[1] if additionals
          values << v
        else
          para = col.match(/<p>(.+?)<\/p>/)
          if para
            values << para[1]
          else
            values << col.match(/^(.+?)<\/td>/)[1]
          end
        end
      end
      entry = {}
      attr_values.each_with_index do |a, ind|
        entry[a] = values[ind]
      end
      result << entry
    end
    return result
  end
end

class Summary
  def dump_summary(res)
    table = {"" => []}
    res.examples.each do |e|
      e.metadata.fetch(:doc_refs, [""]).each do |id|
        next if id == "IGNORE"
        table[id] ||= []
        table[id] << {
          "location" => e.location.gsub("./",""),
          "description" => e.full_description,
        }
      end
    end
    folder = File.dirname(__FILE__) + "/../../documentation/source/pages/requirements-generated"
    FileUtils.mkdir_p(folder)
    File.write(folder + "/mapping.json", JSON.pretty_generate(table))
  end
end

RSpec.configure do |config|
  config.reporter.register_listener(Summary.new, :dump_summary)
  config.before(:all) do |the_test|
    $stdout.write "Testing #{the_test.class}:\n"
  end
  config.after(:all) do |the_test|
    puts "\nDONE"
  end

  config.after(:each) do |the_test|
    if !the_test.instance_variable_get(:@exception).nil?
      if the_test.example_group_instance.instance_variable_defined?("@test")
        test = the_test.example_group_instance.instance_variable_get("@test")
        puts test.test_stdout
        puts test.test_stderr
      end
    end
  end
end
