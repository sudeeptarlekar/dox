require_relative 'framework/helper'

module Sphinx
  describe "dox_trace" do
    context 'HTML output' do
      before(:all) do
        @test = Test.new("html")
        @test.run
      end

      it 'shall support incremental build and enforce a rebuild if the extension version has changed',
        doc_refs: ['DoxTrace_HTML_Incremental', 'DoxTrace_HTML_Version'] do
        expect(@test.exit_code).to be == 0

        expect(File.exist?("#{$test_input_dir}/html/build/html/subpage.html")).to be true
        time1 = File.mtime("#{$test_input_dir}/html/build/html/subpage.html")

        # incremental build rewrites subpage due to changed configuration
        sleep(2)
        test2a = Test.new("html", "DOXTRACE_PROJECT_NAME=Abc")
        test2a.run
        time2a = File.mtime("#{$test_input_dir}/html/build/html/subpage.html")
        expect(time1).not_to eq(time2a)
        test2b = Test.new("html")
        test2b.run
        time2b = File.mtime("#{$test_input_dir}/html/build/html/subpage.html")

        # incremental build does not rewrite subpage because nothing has changed
        sleep(2)
        test3 = Test.new("html")
        test3.run
        time3 = File.mtime("#{$test_input_dir}/html/build/html/subpage.html")
        expect(time2b).to eq(time3)

        # incremental build rewrites subpage due to changed extension version
        sleep(2)
        test4 = Test.new("html", "MANIPULATE_DOXTRACE_VERSION=1")
        test4.run
        time4 = File.mtime("#{$test_input_dir}/html/build/html/subpage.html")
        expect(time3).not_to eq(time4)

        # incremental build does not rewrite subpage because only subpage2 was changed
        sleep(2)
        FileUtils.touch("#{$test_input_dir}/html/subpage2.rst")
        test5 = Test.new("html", "MANIPULATE_DOXTRACE_VERSION=1")
        test5.run
        time5 = File.mtime("#{$test_input_dir}/html/build/html/subpage.html")
        expect(time4).to eq(time5)
        expect(test5.exit_code).to be == 0

        # incremental build rewrites subpage because now subpage was changed
        sleep(2)
        FileUtils.touch("#{$test_input_dir}/html/subpage.rst")
        test6 = Test.new("html", "MANIPULATE_DOXTRACE_VERSION=1")
        test6.run
        time6 = File.mtime("#{$test_input_dir}/html/build/html/subpage.html")
        expect(time5).not_to eq(time6)
        expect(test5.exit_code).to be == 0
      end

      it 'shall contain a table with attributes for every specification in correct design',
        doc_refs: ['DoxTrace_HTML_Table', 'DoxTrace_HTML_Attributes', 'DoxTrace_HTML_Strike', 'DoxTrace_HTML_Background'] do

        data = HtmlData.new("html", "index.html")
        expect(data.html.scan(/<table class="dox-trace-border/).length).to be 10

        attributes = ["Status", "Review Status",
         "Asil", "Cal", "Developer", "Tester", "Test Setups", "Tags",
         "Verification Criteria", "Comment", "Feature", "Change Request", "Miscellaneous", "Verification Criteria",
         "Upstream References", "Downstream References", "Sources",
         "Upstream Asil", "Upstream Cal", "Upstream Tags", "Derived Feature", "Derived Change Request",
         "Reuse", "Usage", "Location"]

        attributes.each do |a|
          regex = /<span class="dox-trace-grey[^"]*">( \| )*<strong>#{a}:<\/strong> (-|\[missing\])/
          if ["Upstream Tags", "Upstream Cal", "Upstream Security", "Upstream Asil", "Derived", "References"].any? {|str| a.include?(str)}
            # calculated attributes in grey
            expect(data.html).to match(regex)
          else
            # no grey color means default = black
            expect(data.html).not_to match(regex)
          end
        end

        expect(data.struck?("Requirement_Normal")).to be false
        expect(data.struck?("Requirement_Invalid")).to be true
        expect(data.struck?("Requirement_Rejected")).to be true
        expect(data.struck?("Requirement_NotRelevant")).to be true

        # value and existence of content checked below
        # row-even / row-odd are RTD theme defaults with white / grey background color
        data.html.gsub!(/<tr class="row-even"><td><p>\s*\[missing\]\s*<\/p><\/td><\/tr>/m, "")
        data.html.gsub!(/<tr class="row-even" hidden\/>/, "")
        expect(data.html).not_to match(/row-even/) # content deleted above
        expect(data.html).to match(/row-odd/) # only the other grey rows are still here
      end

      it 'shall contain type and ID for every specification in correct design', doc_refs: ['DoxTrace_HTML_TypeID'] do
        data = HtmlData.new("html", "index.html")

        type_id_str = ->(type, id) {
            # highlight class = font type / background
            # href = link to itself
            /<code class="[^"]*highlight-#{type}.*\[#{type}\].*href="##{id.downcase}"><span class="pre">#{id}<\/span><\/a><\/code>/
        }
        expect(data.html).to match(type_id_str.("requirement", "Requirement_Normal"))
        expect(data.html).to match(type_id_str.("information", "Information_Normal"))
        expect(data.html).to match(type_id_str.("srs", "SRS_Srs_Normal"))
        expect(data.html).to match(type_id_str.("spec", "SWA_Spec_Normal"))
        expect(data.html).to match(type_id_str.("unit", "SMD_Unit_Normal"))
        expect(data.html).to match(type_id_str.("interface", "SWA_Interface_Normal"))
        expect(data.html).to match(type_id_str.("mod", "SWA_Mod_Normal"))

        css = File.read("#{$test_input_dir}/html/build/html/_static/dox_trace.css")
        expect(css).to match(/highlight-requirement.*background: #FFFFFF.*color:#222222.*font-weight: bold/)
        expect(css).to match(/highlight-interface.*background: #FFFFFF.*color:#222222.*font-weight: bold/)
        expect(css).to match(/highlight-srs.*background: #FFFFFF.*color:#222222.*font-weight: bold/)
        expect(css).to match(/highlight-unit.*background: #FFFFFF.*color:#222222.*font-weight: bold/)
        expect(css).to match(/highlight-spec.*background: #FFFFFF.*color:#222222.*font-weight: bold/)
        expect(css).to match(/highlight-mod.*background: #FFFFFF.*color:#222222.*font-weight: bold/)
        expect(css).to match(/highlight-information.*background: #FFFFFF.*color:#999999.*font-weight: bold/)
      end
    end
  end
end
