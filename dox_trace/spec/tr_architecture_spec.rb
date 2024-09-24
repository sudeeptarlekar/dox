require_relative 'framework/helper'

module Sphinx
  describe "The traceability report for architecture" do

    context 'status table' do
      table_desc = "type = spec / interface / mod |br| developer = Abc AG"
      context 'with no data' do
        before(:all) do
          @test = Test.new("tr_architecture_status_none")
          @test.run
        end
        it 'shall display an appropriate note instead of an empty table', doc_refs: ['DoxTrace_HTML_TraceabilityReportArchitecture'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_architecture_status_none", "report.html")
          expect(data.tr_nodata?("Status")).to be true
          expect(data.tr_desc("Status")).to include table_desc
        end
      end

      context 'with all data filtered out' do
        before(:all) do
          @test = Test.new("tr_architecture_status_empty")
          @test.run
        end
        it 'shall display an appropriate note instead of an empty table', doc_refs: ['DoxTrace_HTML_TraceabilityReportArchitecture'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_architecture_status_empty", "report.html")
          expect(data.tr_nodata?("Status")).to be true
          expect(data.tr_desc("Status")).to include table_desc
        end
      end

      context 'with valid data' do
        before(:all) do
          @test = Test.new("tr_architecture_status_table")
          @test.run
        end
        it 'shall contain correct data with module/value pairs including TOTAL and links', doc_refs: ['DoxTrace_HTML_TraceabilityReportArchitecture'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_architecture_status_table", "report.html")
          expect(data.tr_nodata?("Status")).to be false
          expect(data.tr_desc("Status")).to include table_desc

          v = data.tr_values("Status")

          expect(v["TOTAL"]["all"]).to match_array ["SWA_Req_draft1", "SWA_Req_draft2", "SWA_Req_invalid1", "SWA_Req_valid1", "SWA_Req_valid2", "SWA_Second_valid3"]
          expect(v["TOTAL"]["valid"]).to match_array ["SWA_Req_valid1", "SWA_Req_valid2", "SWA_Second_valid3"]
          expect(v["TOTAL"]["draft"]).to match_array ["SWA_Req_draft1", "SWA_Req_draft2"]
          expect(v["TOTAL"]["invalid"]).to match_array ["SWA_Req_invalid1"]
          expect(v["SWA_Req"]["all"]).to match_array ["SWA_Req_draft1", "SWA_Req_draft2", "SWA_Req_invalid1", "SWA_Req_valid1", "SWA_Req_valid2"]
          expect(v["SWA_Req"]["valid"]).to match_array ["SWA_Req_valid1", "SWA_Req_valid2"]
          expect(v["SWA_Req"]["draft"]).to match_array ["SWA_Req_draft1", "SWA_Req_draft2"]
          expect(v["SWA_Req"]["invalid"]).to match_array ["SWA_Req_invalid1"]
          expect(v["SWA_Second"]["all"]).to match_array ["SWA_Second_valid3"]
          expect(v["SWA_Second"]["valid"]).to match_array ["SWA_Second_valid3"]
          expect(v["SWA_Second"]["draft"]).to match_array []
          expect(v["SWA_Second"]["invalid"]).to match_array []
        end
      end
    end

    context 'type table' do
      table_desc = "type = spec / interface / mod |br| developer = Abc AG |br| status = valid"
      context 'with no data' do
        before(:all) do
          @test = Test.new("tr_architecture_type_none")
          @test.run
        end
        it 'shall display an appropriate note instead of an empty table', doc_refs: ['DoxTrace_HTML_TraceabilityReportArchitecture'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_architecture_type_none", "report.html")
          expect(data.tr_nodata?("Type")).to be true
          expect(data.tr_desc("Type")).to include table_desc
        end
      end

      context 'with all data filtered out' do
        before(:all) do
          @test = Test.new("tr_architecture_type_empty")
          @test.run
        end
        it 'shall display an appropriate note instead of an empty table', doc_refs: ['DoxTrace_HTML_TraceabilityReportArchitecture'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_architecture_type_empty", "report.html")
          expect(data.tr_nodata?("Type")).to be true
          expect(data.tr_desc("Type")).to include table_desc
        end
      end

      context 'with valid data' do
        before(:all) do
          @test = Test.new("tr_architecture_type_table")
          @test.run
        end
        it 'shall contain correct data with module/value pairs including TOTAL and links', doc_refs: ['DoxTrace_HTML_TraceabilityReportArchitecture'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_architecture_type_table", "report.html")
          expect(data.tr_nodata?("Type")).to be false
          expect(data.tr_desc("Type")).to include table_desc

          v = data.tr_values("Type")

          expect(v["TOTAL"]["all"]).to match_array ["SWA_Req_interface1", "SWA_Req_mod1", "SWA_Req_spec1", "SWA_Req_spec2", "SWA_Req_spec3", "SWA_Second_interface2"]
          expect(v["TOTAL"]["spec"]).to match_array ["SWA_Req_spec1", "SWA_Req_spec2", "SWA_Req_spec3"]
          expect(v["TOTAL"]["interface"]).to match_array ["SWA_Req_interface1", "SWA_Second_interface2"]
          expect(v["TOTAL"]["mod"]).to match_array ["SWA_Req_mod1"]
          expect(v["SWA_Req"]["all"]).to match_array ["SWA_Req_interface1", "SWA_Req_mod1", "SWA_Req_spec1", "SWA_Req_spec2", "SWA_Req_spec3"]
          expect(v["SWA_Req"]["spec"]).to match_array ["SWA_Req_spec1", "SWA_Req_spec2", "SWA_Req_spec3"]
          expect(v["SWA_Req"]["interface"]).to match_array ["SWA_Req_interface1"]
          expect(v["SWA_Req"]["mod"]).to match_array ["SWA_Req_mod1"]
          expect(v["SWA_Second"]["all"]).to match_array ["SWA_Second_interface2"]
          expect(v["SWA_Second"]["spec"]).to match_array []
          expect(v["SWA_Second"]["interface"]).to match_array ["SWA_Second_interface2"]
          expect(v["SWA_Second"]["mod"]).to match_array []
        end
      end
    end

    context 'safety table' do
      table_desc = "type = spec / interface / mod |br| developer = Abc AG |br| status = valid"
      context 'with no data' do
        before(:all) do
          @test = Test.new("tr_architecture_safety_none")
          @test.run
        end
        it 'shall display an appropriate note instead of an empty table', doc_refs: ['DoxTrace_HTML_TraceabilityReportArchitecture'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_architecture_safety_none", "report.html")
          expect(data.tr_nodata?("Functional Safety")).to be true
          expect(data.tr_desc("Functional Safety")).to include table_desc
        end
      end

      context 'with all data filtered out' do
        before(:all) do
          @test = Test.new("tr_architecture_safety_empty")
          @test.run
        end
        it 'shall display an appropriate note instead of an empty table', doc_refs: ['DoxTrace_HTML_TraceabilityReportArchitecture'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_architecture_safety_empty", "report.html")
          expect(data.tr_nodata?("Functional Safety")).to be true
          expect(data.tr_desc("Functional Safety")).to include table_desc
        end
      end

      context 'with valid data' do
        before(:all) do
          @test = Test.new("tr_architecture_safety_table")
          @test.run
        end
        it 'shall contain correct data with module/value pairs including TOTAL and links', doc_refs: ['DoxTrace_HTML_TraceabilityReportArchitecture'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_architecture_safety_table", "report.html")
          expect(data.tr_nodata?("Functional Safety")).to be false
          expect(data.tr_desc("Functional Safety")).to include table_desc

          v = data.tr_values("Functional Safety")

          expect(v["TOTAL"]["all"]).to match_array ["SWA_Req_A1", "SWA_Req_A2", "SWA_Req_B(C)1", "SWA_Req_notset1", "SWA_Second_QM"]
          expect(v["TOTAL"]["ASIL_A"]).to match_array ["SWA_Req_A1", "SWA_Req_A2"]
          expect(v["TOTAL"]["ASIL_B(C)"]).to match_array ["SWA_Req_B(C)1"]
          expect(v["TOTAL"]["QM"]).to match_array ["SWA_Second_QM"]
          expect(v["TOTAL"]["not_set"]).to match_array ["SWA_Req_notset1"]
          expect(v["SWA_Req"]["all"]).to match_array ["SWA_Req_A1", "SWA_Req_A2", "SWA_Req_B(C)1", "SWA_Req_notset1"]
          expect(v["SWA_Req"]["ASIL_A"]).to match_array ["SWA_Req_A1", "SWA_Req_A2"]
          expect(v["SWA_Req"]["ASIL_B(C)"]).to match_array ["SWA_Req_B(C)1"]
          expect(v["SWA_Req"]["QM"]).to match_array []
          expect(v["SWA_Req"]["not_set"]).to match_array ["SWA_Req_notset1"]
          expect(v["SWA_Second"]["all"]).to match_array ["SWA_Second_QM"]
          expect(v["SWA_Second"]["ASIL_A"]).to match_array []
          expect(v["SWA_Second"]["ASIL_B(C)"]).to match_array []
          expect(v["SWA_Second"]["QM"]).to match_array ["SWA_Second_QM"]
          expect(v["SWA_Second"]["not_set"]).to match_array []
        end
      end
    end

    context 'cal table' do
      table_desc = "type = spec / interface / mod |br| developer = Abc AG |br| status = valid"
      context 'with no data' do
        before(:all) do
          @test = Test.new("tr_architecture_cal_none")
          @test.run
        end
        it 'shall display an appropriate note instead of an empty table', doc_refs: ['DoxTrace_HTML_TraceabilityReportArchitecture'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_architecture_cal_none", "report.html")
          expect(data.tr_nodata?("Cyber Security")).to be true
          expect(data.tr_desc("Cyber Security")).to include table_desc
        end
      end

      context 'with all data filtered out' do
        before(:all) do
          @test = Test.new("tr_architecture_cal_empty")
          @test.run
        end
        it 'shall display an appropriate note instead of an empty table', doc_refs: ['DoxTrace_HTML_TraceabilityReportArchitecture'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_architecture_cal_empty", "report.html")
          expect(data.tr_nodata?("Cyber Security")).to be true
          expect(data.tr_desc("Cyber Security")).to include table_desc
        end
      end

      context 'with valid data' do
        before(:all) do
          @test = Test.new("tr_architecture_cal_table")
          @test.run
        end
        it 'shall contain correct data with module/value pairs including TOTAL and links', doc_refs: ['DoxTrace_HTML_TraceabilityReportArchitecture'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_architecture_cal_table", "report.html")
          expect(data.tr_nodata?("Cyber Security")).to be false
          expect(data.tr_desc("Cyber Security")).to include table_desc

          v = data.tr_values("Cyber Security")

          expect(v["TOTAL"]["all"]).to match_array ["SWA_Req_qm1", "SWA_Req_notset1", "SWA_Req_cal1", "SWA_Req_yes1", "SWA_Second_qm2"]
          expect(v["TOTAL"]["CAL_1"]).to match_array ["SWA_Req_cal1"]
          expect(v["TOTAL"]["CAL_4"]).to match_array ["SWA_Req_yes1"]
          expect(v["TOTAL"]["QM"]).to match_array ["SWA_Req_qm1", "SWA_Second_qm2"]
          expect(v["TOTAL"]["not_set"]).to match_array ["SWA_Req_notset1"]
          expect(v["SWA_Req"]["all"]).to match_array ["SWA_Req_qm1", "SWA_Req_notset1", "SWA_Req_cal1", "SWA_Req_yes1"]
          expect(v["SWA_Req"]["CAL_1"]).to match_array ["SWA_Req_cal1"]
          expect(v["SWA_Req"]["CAL_4"]).to match_array ["SWA_Req_yes1"]
          expect(v["SWA_Req"]["QM"]).to match_array ["SWA_Req_qm1"]
          expect(v["SWA_Req"]["not_set"]).to match_array ["SWA_Req_notset1"]
          expect(v["SWA_Second"]["all"]).to match_array ["SWA_Second_qm2"]
          expect(v["SWA_Second"]["CAL_1"]).to match_array []
          expect(v["SWA_Second"]["CAL_1"]).to match_array []
          expect(v["SWA_Second"]["QM"]).to match_array ["SWA_Second_qm2"]
          expect(v["SWA_Second"]["not_set"]).to match_array []
        end
      end
    end

    context 'security table' do
      table_desc = "type = spec / interface / mod |br| developer = Abc AG |br| status = valid"
      context 'with no data' do
        before(:all) do
          @test = Test.new("tr_architecture_security_none")
          @test.run
        end
        it 'shall display an appropriate note instead of an empty table', doc_refs: ['DoxTrace_HTML_TraceabilityReportArchitecture'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_architecture_security_none", "report.html")
          expect(data.tr_nodata?("Cyber Security")).to be true
          expect(data.tr_desc("Cyber Security")).to include table_desc
        end
      end

      context 'with all data filtered out' do
        before(:all) do
          @test = Test.new("tr_architecture_security_empty")
          @test.run
        end
        it 'shall display an appropriate note instead of an empty table', doc_refs: ['DoxTrace_HTML_TraceabilityReportArchitecture'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_architecture_security_empty", "report.html")
          expect(data.tr_nodata?("Cyber Security")).to be true
          expect(data.tr_desc("Cyber Security")).to include table_desc
        end
      end

      context 'with valid data' do
        before(:all) do
          @test = Test.new("tr_architecture_security_table")
          @test.run
        end
        it 'shall contain correct data with module/value pairs including TOTAL and links', doc_refs: ['DoxTrace_HTML_TraceabilityReportArchitecture'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_architecture_security_table", "report.html")
          expect(data.tr_nodata?("Cyber Security")).to be false
          expect(data.tr_desc("Cyber Security")).to include table_desc

          v = data.tr_values("Cyber Security")

          expect(v["TOTAL"]["all"]).to match_array ["SWA_Req_no1", "SWA_Req_notset1", "SWA_Req_yes1", "SWA_Req_yes2", "SWA_Second_no2"]
          expect(v["TOTAL"]["yes"]).to match_array ["SWA_Req_yes1", "SWA_Req_yes2"]
          expect(v["TOTAL"]["no"]).to match_array ["SWA_Req_no1", "SWA_Second_no2"]
          expect(v["TOTAL"]["not_set"]).to match_array ["SWA_Req_notset1"]
          expect(v["SWA_Req"]["all"]).to match_array ["SWA_Req_no1", "SWA_Req_notset1", "SWA_Req_yes1", "SWA_Req_yes2"]
          expect(v["SWA_Req"]["yes"]).to match_array ["SWA_Req_yes1", "SWA_Req_yes2"]
          expect(v["SWA_Req"]["no"]).to match_array ["SWA_Req_no1"]
          expect(v["SWA_Req"]["not_set"]).to match_array ["SWA_Req_notset1"]
          expect(v["SWA_Second"]["all"]).to match_array ["SWA_Second_no2"]
          expect(v["SWA_Second"]["yes"]).to match_array []
          expect(v["SWA_Second"]["no"]).to match_array ["SWA_Second_no2"]
          expect(v["SWA_Second"]["not_set"]).to match_array []
        end
      end
    end

    context 'referenced/derived table' do
      table_desc = "type = spec / interface / mod |br| developer = Abc AG |br| status = valid"
      context 'with no data' do
        before(:all) do
          @test = Test.new("tr_architecture_ref_none")
          @test.run
        end
        it 'shall display an appropriate note instead of an empty table', doc_refs: ['DoxTrace_HTML_TraceabilityReportArchitecture'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_architecture_ref_none", "report.html")
          expect(data.tr_nodata?("Upstream and Downstream")).to be true
          expect(data.tr_desc("Upstream and Downstream")).to include table_desc
        end
      end

      context 'with all data filtered out' do
        before(:all) do
          @test = Test.new("tr_architecture_ref_empty")
          @test.run
        end
        it 'shall display an appropriate note instead of an empty table', doc_refs: ['DoxTrace_HTML_TraceabilityReportArchitecture'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_architecture_ref_empty", "report.html")
          expect(data.tr_nodata?("Upstream and Downstream")).to be true
          expect(data.tr_desc("Upstream and Downstream")).to include table_desc
        end
      end

      context 'with valid data' do
        before(:all) do
          @test = Test.new("tr_architecture_ref_table")
          @test.run
        end
        it 'shall contain correct data with module/value pairs including TOTAL and links', doc_refs: ['DoxTrace_HTML_TraceabilityReportArchitecture'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_architecture_ref_table", "report.html")
          expect(data.tr_nodata?("Upstream and Downstream")).to be false
          expect(data.tr_desc("Upstream and Downstream")).to include table_desc

          v = data.tr_values("Upstream and Downstream")

          expect(v["TOTAL"]["all"]).to match_array ["SWA_Req_deref1", "SWA_Req_deref2", "SWA_Req_deref3", "SWA_Req_deref4", "SWA_Req_deref5",
            "SWA_Level_all", "SWA_Level_input", "SWA_Level_none", "SWA_Level_software", "SWA_Level_srs", "SWA_Level_swa",
            "SWA_Req_no1", "SWA_Second_ref1", "SWA_Parent_swa", "SWA_Req_refderef1", "SWA_Req_refderef2"]
          expect(v["TOTAL"]["Downstream Sufficient"]).to match_array ["SWA_Parent_swa", "SWA_Req_deref1", "SWA_Req_deref2", "SWA_Req_deref3", "SWA_Req_deref4", "SWA_Req_deref5", "SWA_Req_refderef1", "SWA_Req_refderef2"]
          expect(v["TOTAL"]["Downstream Missing"]).to match_array ["SWA_Level_all", "SWA_Level_input", "SWA_Level_none", "SWA_Level_software", "SWA_Level_srs", "SWA_Level_swa", "SWA_Req_no1", "SWA_Second_ref1"]
          expect(v["TOTAL"]["Upstream Sufficient"]).to match_array ["SWA_Second_ref1", "SWA_Req_refderef1", "SWA_Req_refderef2", "SWA_Level_all", "SWA_Level_software", "SWA_Level_srs", "SWA_Level_swa"]
          expect(v["TOTAL"]["Upstream Missing"]).to match_array ["SWA_Level_input", "SWA_Level_none", "SWA_Parent_swa", "SWA_Req_deref1", "SWA_Req_deref2", "SWA_Req_deref3", "SWA_Req_deref4", "SWA_Req_deref5", "SWA_Req_no1"]

          expect(v["SWA_Req"]["all"]).to match_array ["SWA_Req_deref1", "SWA_Req_deref2", "SWA_Req_deref3", "SWA_Req_deref4", "SWA_Req_deref5", "SWA_Req_no1", "SWA_Req_refderef1", "SWA_Req_refderef2"]
          expect(v["SWA_Req"]["Downstream Sufficient"]).to match_array ["SWA_Req_deref1", "SWA_Req_deref2", "SWA_Req_deref3", "SWA_Req_deref4", "SWA_Req_deref5", "SWA_Req_refderef1", "SWA_Req_refderef2"]
          expect(v["SWA_Req"]["Downstream Missing"]).to match_array ["SWA_Req_no1"]
          expect(v["SWA_Req"]["Upstream Sufficient"]).to match_array ["SWA_Req_refderef1", "SWA_Req_refderef2"]
          expect(v["SWA_Req"]["Upstream Missing"]).to match_array ["SWA_Req_deref1", "SWA_Req_deref2", "SWA_Req_deref3", "SWA_Req_deref4", "SWA_Req_deref5", "SWA_Req_no1"]

          expect(v["SWA_Second"]["all"]).to match_array ["SWA_Second_ref1"]
          expect(v["SWA_Second"]["Downstream Sufficient"]).to match_array []
          expect(v["SWA_Second"]["Downstream Missing"]).to match_array ["SWA_Second_ref1"]
          expect(v["SWA_Second"]["Upstream Sufficient"]).to match_array ["SWA_Second_ref1"]
          expect(v["SWA_Second"]["Upstream Missing"]).to match_array []

          expect(v["SWA_Parent"]["all"]).to match_array ["SWA_Parent_swa"]
          expect(v["SWA_Parent"]["Downstream Sufficient"]).to match_array ["SWA_Parent_swa"]
          expect(v["SWA_Parent"]["Downstream Missing"]).to match_array []
          expect(v["SWA_Parent"]["Upstream Sufficient"]).to match_array []
          expect(v["SWA_Parent"]["Upstream Missing"]).to match_array ["SWA_Parent_swa"]

          expect(v["SWA_Level"]["all"]).to match_array ["SWA_Level_all", "SWA_Level_input", "SWA_Level_none", "SWA_Level_software", "SWA_Level_srs", "SWA_Level_swa"]
          expect(v["SWA_Level"]["Downstream Sufficient"]).to match_array []
          expect(v["SWA_Level"]["Downstream Missing"]).to match_array ["SWA_Level_all", "SWA_Level_input", "SWA_Level_none", "SWA_Level_software", "SWA_Level_srs", "SWA_Level_swa"]
          expect(v["SWA_Level"]["Upstream Sufficient"]).to match_array ["SWA_Level_all", "SWA_Level_swa", "SWA_Level_software", "SWA_Level_srs"]
          expect(v["SWA_Level"]["Upstream Missing"]).to match_array ["SWA_Level_input", "SWA_Level_none"]
        end
      end
    end

    context 'list of specifications' do
      table_desc = "type = spec / interface / mod |br| developer = Abc AG |br| status = valid"
      context 'with no data' do
        before(:all) do
          @test = Test.new("tr_architecture_list_none")
          @test.run
        end
        it 'shall display an appropriate note instead of an empty table', doc_refs: ['DoxTrace_HTML_TraceabilityReportArchitecture'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_architecture_ref_none", "report.html")
          expect(data.tr_nodata?("List of Specifications")).to be true
          expect(data.tr_desc("List of Specifications")).to include table_desc
        end
      end

      context 'with all data filtered out' do
        before(:all) do
          @test = Test.new("tr_architecture_list_empty")
          @test.run
        end
        it 'shall display an appropriate note instead of an empty table', doc_refs: ['DoxTrace_HTML_TraceabilityReportArchitecture'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_architecture_ref_empty", "report.html")
          expect(data.tr_nodata?("List of Specifications")).to be true
          expect(data.tr_desc("List of Specifications")).to include table_desc
        end
      end

      context 'with valid data' do
        before(:all) do
          @test = Test.new("tr_architecture_list_table")
          @test.run
        end
        it 'shall contain correct data with module/value pairs including TOTAL and links', doc_refs: ['DoxTrace_HTML_TraceabilityReportArchitecture'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_architecture_list_table", "report.html")
          expect(data.tr_nodata?("List of Specifications")).to be false
          expect(data.tr_desc("List of Specifications")).to include table_desc

          v = data.tr_list("List of Specifications")
          expect(v.length). to be 9

          table = {"SWA_Req_deref1" =>    {"mod" => "SWA_Req",    "Downstream" => "SWA_Req_refderef1, SWA_Req_refderef2, SWA_Second_ref1", "Upstream" => "[missing]"},
                   "SWA_Req_deref2" =>    {"mod" => "SWA_Req",    "Downstream" => "SWA_Req_notset2, index.rst, second.rst",                "Upstream" => "[missing]"},
                   "SWA_Req_deref3" =>    {"mod" => "SWA_Req",    "Downstream" => "index.rst",                                             "Upstream" => "[missing]"},
                   "SWA_Req_deref4" =>    {"mod" => "SWA_Req",    "Downstream" => "abc",                                                   "Upstream" => "[missing]"},
                   "SWA_Req_deref5" =>    {"mod" => "SWA_Req",    "Downstream" => "efg",                                                   "Upstream" => "[missing]"},
                   "SWA_Req_no1" =>       {"mod" => "SWA_Req",    "Downstream" => "[missing]",                                             "Upstream" => "[missing]"},
                   "SWA_Req_refderef1" => {"mod" => "SWA_Req",    "Downstream" => "SWA_Req_refderef2",                                     "Upstream" => "SRS_Req_info1, SWA_Req_deref1, SWA_Req_notset3"},
                   "SWA_Req_refderef2" => {"mod" => "SWA_Req",    "Downstream" => "SWA_Req_notset2",                                       "Upstream" => "SWA_Req_deref1, SWA_Req_refderef1"},
                   "SWA_Second_ref1" =>   {"mod" => "SWA_Second", "Downstream" => "[missing]",                                             "Upstream" => "SWA_Req_deref1"}}
          v.each do |content|
            t = table[content["ID"]]
            expect(content["mod"]).to eq t["mod"]
            expect(content["Downstream"]).to eq t["Downstream"]
            expect(content["Upstream"]).to eq t["Upstream"]
          end
        end
      end
    end

  end
end
