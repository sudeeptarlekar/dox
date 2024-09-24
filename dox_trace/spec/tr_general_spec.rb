require_relative 'framework/helper'

module Sphinx
  describe "The traceability report" do

    context 'shall determine the module name of the specifications' do
      before(:all) do
        @test = Test.new("tr_general_notitle")
        @test.run
      end
      it 'and if not possible, use "Unknown" as fallback', doc_refs: ['DoxTrace_HTML_TraceabilityReportUnknownModule'] do
        expect(@test.exit_code).to be == 0

        data = HtmlData.new("tr_general_notitle", "report.html")
        v = data.tr_values("Developer")
        expect(v["TOTAL"]["all"]).to match_array ["CRS_Req_notset1"]
        expect(v["TOTAL"]["Abc AG"]).to match_array []
        expect(v["TOTAL"]["other"]).to match_array []
        expect(v["TOTAL"]["not set"]).to match_array ["CRS_Req_notset1"]
        expect(v["Unknown"]["all"]).to match_array ["CRS_Req_notset1"]
        expect(v["Unknown"]["Abc AG"]).to match_array []
        expect(v["Unknown"]["other"]).to match_array []
        expect(v["Unknown"]["not set"]).to match_array ["CRS_Req_notset1"]
      end
    end

    context 'with invalid traceability report category' do
      before(:all) do
        @test = Test.new("tr_general_invalidcategory")
        @test.run
      end
      it 'shall abort and print an appropriate error message', doc_refs: ['DoxTrace_HTML_TraceabilityReportUnknownCategory'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'report.rst:7: category must be input, software, architecture, module or source'
      end
    end

    context 'shall have an option to filter for developers' do
      before(:all) do
        @test = Test.new("tr_general_missingdeveloper")
        @test.run
      end
      it 'and abort the build if not specified', doc_refs: ['DoxTrace_HTML_TraceabilityDeveloper'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'report.rst:7: developer option not specified'
      end
    end

    context 'shall be tolerant with filtering for developer' do
      before(:all) do
        @test = Test.new("tr_general_developerregex")
        @test.run
      end
      it 'using a generic regex', doc_refs: ['DoxTrace_HTML_TraceabilityDeveloper'] do
        expect(@test.exit_code).to be == 0
        data = HtmlData.new("tr_general_developerregex", "report.html")
        expect(data.tr_nodata?("Status")).to be false
        v = data.tr_values("Status")
        expect(v["TOTAL"]["all"]).to match_array ["SRS_Req_ok1", "SRS_Req_ok2", "SRS_Req_ok3", "SRS_Req_ok4", "SRS_Req_ok5", "SRS_Req_ok6", "SRS_Req_ok7"]
      end
    end

    context 'shall ignore' do
      before(:all) do
        @test = Test.new("tr_general_ignore")
        @test.run
      end
      it 'specifications with attribute ignore_in_export', doc_refs: ['DoxTrace_HTML_TraceabilityReportIgnore'] do
        expect(@test.exit_code).to be == 0
        data = HtmlData.new("tr_general_ignore", "report.html")

        v = data.tr_values("Status")
        expect(v["TOTAL"]["all"]).to match_array ["SMD_Req_2"]
        expect(v["TOTAL"]["valid"]).to match_array []
        expect(v["TOTAL"]["draft"]).to match_array ["SMD_Req_2"]
        expect(v["TOTAL"]["invalid"]).to match_array []
        expect(v["SMD_Req"]["all"]).to match_array ["SMD_Req_2"]
        expect(v["SMD_Req"]["valid"]).to match_array []
        expect(v["SMD_Req"]["draft"]).to match_array ["SMD_Req_2"]
        expect(v["SMD_Req"]["invalid"]).to match_array []
      end
    end

  end
end
