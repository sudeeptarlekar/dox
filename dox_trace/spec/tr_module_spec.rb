require_relative 'framework/helper'

module Sphinx
  describe "The traceability report for module" do

    context 'status table' do
      table_desc_deprecated = "type = spec / interface / unit |br| developer = Abc AG"
      table_desc = "type = spec / unit |br| developer = Abc AG"
      context 'with no data' do
        before(:all) do
          @test = Test.new("tr_module_status_none")
          @test.run
        end
        it 'shall display an appropriate note instead of an empty table', doc_refs: ['DoxTrace_HTML_TraceabilityReportModule'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_module_status_none", "report.html")
          expect(data.tr_nodata?("Status")).to be true
          expect(data.tr_desc("Status")).to include table_desc
        end
      end

      context 'with all data filtered out' do
        before(:all) do
          @test = Test.new("tr_module_status_empty")
          @test.run
        end
        it 'shall display an appropriate note instead of an empty table', doc_refs: ['DoxTrace_HTML_TraceabilityReportModule'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_module_status_empty", "report.html")
          expect(data.tr_nodata?("Status")).to be true
          expect(data.tr_desc("Status")).to include table_desc_deprecated
        end
      end

      context 'with valid data' do
        before(:all) do
          @test = Test.new("tr_module_status_table")
          @test.run
        end
        it 'shall contain correct data with module/value pairs including TOTAL and links', doc_refs: ['DoxTrace_HTML_TraceabilityReportModule'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_module_status_table", "report.html")
          expect(data.tr_nodata?("Status")).to be false
          expect(data.tr_desc("Status")).to include table_desc_deprecated

          v = data.tr_values("Status")

          expect(v["TOTAL"]["all"]).to match_array ["SMD_Req_draft1", "SMD_Req_draft2", "SMD_Req_invalid1", "SMD_Req_valid1", "SMD_Req_valid2", "SMD_Second_valid3"]
          expect(v["TOTAL"]["valid"]).to match_array ["SMD_Req_valid1", "SMD_Req_valid2", "SMD_Second_valid3"]
          expect(v["TOTAL"]["draft"]).to match_array ["SMD_Req_draft1", "SMD_Req_draft2"]
          expect(v["TOTAL"]["invalid"]).to match_array ["SMD_Req_invalid1"]
          expect(v["SMD_Req"]["all"]).to match_array ["SMD_Req_draft1", "SMD_Req_draft2", "SMD_Req_invalid1", "SMD_Req_valid1", "SMD_Req_valid2"]
          expect(v["SMD_Req"]["valid"]).to match_array ["SMD_Req_valid1", "SMD_Req_valid2"]
          expect(v["SMD_Req"]["draft"]).to match_array ["SMD_Req_draft1", "SMD_Req_draft2"]
          expect(v["SMD_Req"]["invalid"]).to match_array ["SMD_Req_invalid1"]
          expect(v["SMD_Second"]["all"]).to match_array ["SMD_Second_valid3"]
          expect(v["SMD_Second"]["valid"]).to match_array ["SMD_Second_valid3"]
          expect(v["SMD_Second"]["draft"]).to match_array []
          expect(v["SMD_Second"]["invalid"]).to match_array []
        end
      end
    end

    context 'type table' do
      table_desc_deprecated = "type = spec / interface / unit |br| developer = Abc AG |br| status = valid"
      table_desc = "type = spec / unit |br| developer = Abc AG |br| status = valid"
      context 'with no data' do
        before(:all) do
          @test = Test.new("tr_module_type_none")
          @test.run
        end
        it 'shall display an appropriate note instead of an empty table', doc_refs: ['DoxTrace_HTML_TraceabilityReportModule'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_module_type_none", "report.html")
          expect(data.tr_nodata?("Type")).to be true
          expect(data.tr_desc("Type")).to include table_desc
        end
      end

      context 'with all data filtered out' do
        before(:all) do
          @test = Test.new("tr_module_type_empty")
          @test.run
        end
        it 'shall display an appropriate note instead of an empty table', doc_refs: ['DoxTrace_HTML_TraceabilityReportModule'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_module_type_empty", "report.html")
          expect(data.tr_nodata?("Type")).to be true
          expect(data.tr_desc("Type")).to include table_desc_deprecated
        end
      end

      context 'with valid data without deprecated interface type' do
        before(:all) do
          @test = Test.new("tr_module_type_table")
          @test.run
        end
        it 'shall contain correct data with module/value pairs including TOTAL and links', doc_refs: ['DoxTrace_HTML_TraceabilityReportModule'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_module_type_table", "report.html")
          expect(data.tr_nodata?("Type")).to be false
          expect(data.tr_desc("Type")).to include table_desc

          v = data.tr_values("Type")

          expect(v["TOTAL"]["all"]).to match_array ["SMD_Req_spec1", "SMD_Req_spec2", "SMD_Req_spec3", "SMD_Req_unit1", "SMD_Second_unit2"]
          expect(v["TOTAL"]["spec"]).to match_array ["SMD_Req_spec1", "SMD_Req_spec2", "SMD_Req_spec3"]
          expect(v["TOTAL"].include?("interface")).to be false
          expect(v["TOTAL"]["unit"]).to match_array ["SMD_Req_unit1", "SMD_Second_unit2"]
          expect(v["SMD_Req"]["all"]).to match_array ["SMD_Req_spec1", "SMD_Req_spec2", "SMD_Req_spec3", "SMD_Req_unit1"]
          expect(v["SMD_Req"]["spec"]).to match_array ["SMD_Req_spec1", "SMD_Req_spec2", "SMD_Req_spec3"]
          expect(v["SMD_Req"]["unit"]).to match_array ["SMD_Req_unit1"]
          expect(v["SMD_Second"]["all"]).to match_array ["SMD_Second_unit2"]
          expect(v["SMD_Second"]["spec"]).to match_array []
          expect(v["SMD_Second"]["unit"]).to match_array ["SMD_Second_unit2"]
        end
      end
      context 'with valid data with deprecated interface type' do
        before(:all) do
          @test = Test.new("tr_module_type_table_deprecated")
          @test.run
        end
        it 'shall contain correct data with module/value pairs including TOTAL and links', doc_refs: ['DoxTrace_HTML_TraceabilityReportModule'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_module_type_table_deprecated", "report.html")
          expect(data.tr_nodata?("Type")).to be false
          expect(data.tr_desc("Type")).to include table_desc_deprecated

          v = data.tr_values("Type")

          expect(v["TOTAL"]["all"]).to match_array ["SMD_Req_interface1", "SMD_Req_spec1", "SMD_Req_spec2", "SMD_Req_spec3", "SMD_Req_unit1", "SMD_Second_unit2"]
          expect(v["TOTAL"]["spec"]).to match_array ["SMD_Req_spec1", "SMD_Req_spec2", "SMD_Req_spec3"]
          expect(v["TOTAL"]["interface"]).to match_array ["SMD_Req_interface1"]
          expect(v["TOTAL"]["unit"]).to match_array ["SMD_Req_unit1", "SMD_Second_unit2"]
          expect(v["SMD_Req"]["all"]).to match_array ["SMD_Req_interface1", "SMD_Req_spec1", "SMD_Req_spec2", "SMD_Req_spec3", "SMD_Req_unit1"]
          expect(v["SMD_Req"]["spec"]).to match_array ["SMD_Req_spec1", "SMD_Req_spec2", "SMD_Req_spec3"]
          expect(v["SMD_Req"]["interface"]).to match_array ["SMD_Req_interface1"]
          expect(v["SMD_Req"]["unit"]).to match_array ["SMD_Req_unit1"]
          expect(v["SMD_Second"]["all"]).to match_array ["SMD_Second_unit2"]
          expect(v["SMD_Second"]["spec"]).to match_array []
          expect(v["SMD_Second"]["interface"]).to match_array []
          expect(v["SMD_Second"]["unit"]).to match_array ["SMD_Second_unit2"]
        end
      end
    end

    context 'safety table' do
      table_desc = "type = spec / unit |br| developer = Abc AG |br| status = valid"
      context 'with no data' do
        before(:all) do
          @test = Test.new("tr_module_safety_none")
          @test.run
        end
        it 'shall display an appropriate note instead of an empty table', doc_refs: ['DoxTrace_HTML_TraceabilityReportModule'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_module_safety_none", "report.html")
          expect(data.tr_nodata?("Functional Safety")).to be true
          expect(data.tr_desc("Functional Safety")).to include table_desc
        end
      end

      context 'with all data filtered out' do
        before(:all) do
          @test = Test.new("tr_module_safety_empty")
          @test.run
        end
        it 'shall display an appropriate note instead of an empty table', doc_refs: ['DoxTrace_HTML_TraceabilityReportModule'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_module_safety_empty", "report.html")
          expect(data.tr_nodata?("Functional Safety")).to be true
          expect(data.tr_desc("Functional Safety")).to include table_desc
        end
      end

      context 'with valid data' do
        before(:all) do
          @test = Test.new("tr_module_safety_table")
          @test.run
        end
        it 'shall contain correct data with module/value pairs including TOTAL and links', doc_refs: ['DoxTrace_HTML_TraceabilityReportModule'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_module_safety_table", "report.html")
          expect(data.tr_nodata?("Functional Safety")).to be false
          expect(data.tr_desc("Functional Safety")).to include table_desc

          v = data.tr_values("Functional Safety")

          expect(v["TOTAL"]["all"]).to match_array ["SMD_Req_A1", "SMD_Req_A2", "SMD_Req_B(C)1", "SMD_Req_notset1", "SMD_Second_QM"]
          expect(v["TOTAL"]["ASIL_A"]).to match_array ["SMD_Req_A1", "SMD_Req_A2"]
          expect(v["TOTAL"]["ASIL_B(C)"]).to match_array ["SMD_Req_B(C)1"]
          expect(v["TOTAL"]["QM"]).to match_array ["SMD_Second_QM"]
          expect(v["TOTAL"]["not_set"]).to match_array ["SMD_Req_notset1"]
          expect(v["SMD_Req"]["all"]).to match_array ["SMD_Req_A1", "SMD_Req_A2", "SMD_Req_B(C)1", "SMD_Req_notset1"]
          expect(v["SMD_Req"]["ASIL_A"]).to match_array ["SMD_Req_A1", "SMD_Req_A2"]
          expect(v["SMD_Req"]["ASIL_B(C)"]).to match_array ["SMD_Req_B(C)1"]
          expect(v["SMD_Req"]["QM"]).to match_array []
          expect(v["SMD_Req"]["not_set"]).to match_array ["SMD_Req_notset1"]
          expect(v["SMD_Second"]["all"]).to match_array ["SMD_Second_QM"]
          expect(v["SMD_Second"]["ASIL_A"]).to match_array []
          expect(v["SMD_Second"]["ASIL_B(C)"]).to match_array []
          expect(v["SMD_Second"]["QM"]).to match_array ["SMD_Second_QM"]
          expect(v["SMD_Second"]["not_set"]).to match_array []
        end
      end
    end

    context 'cal table' do
      table_desc = "type = spec / unit |br| developer = Abc AG |br| status = valid"
      context 'with no data' do
        before(:all) do
          @test = Test.new("tr_module_cal_none")
          @test.run
        end
        it 'shall display an appropriate note instead of an empty table', doc_refs: ['DoxTrace_HTML_TraceabilityReportModule'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_module_cal_none", "report.html")
          expect(data.tr_nodata?("Cyber Security")).to be true
          expect(data.tr_desc("Cyber Security")).to include table_desc
        end
      end

      context 'with all data filtered out' do
        before(:all) do
          @test = Test.new("tr_module_cal_empty")
          @test.run
        end
        it 'shall display an appropriate note instead of an empty table', doc_refs: ['DoxTrace_HTML_TraceabilityReportModule'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_module_cal_empty", "report.html")
          expect(data.tr_nodata?("Cyber Security")).to be true
          expect(data.tr_desc("Cyber Security")).to include table_desc
        end
      end

      context 'with valid data' do
        before(:all) do
          @test = Test.new("tr_module_cal_table")
          @test.run
        end
        it 'shall contain correct data with module/value pairs including TOTAL and links', doc_refs: ['DoxTrace_HTML_TraceabilityReportModule'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_module_cal_table", "report.html")
          expect(data.tr_nodata?("Cyber Security")).to be false
          expect(data.tr_desc("Cyber Security")).to include table_desc

          v = data.tr_values("Cyber Security")

          expect(v["TOTAL"]["all"]).to match_array ["SMD_Req_qm1", "SMD_Req_notset1", "SMD_Req_cal1", "SMD_Req_yes1", "SMD_Second_qm2"]
          expect(v["TOTAL"]["CAL_1"]).to match_array ["SMD_Req_cal1"]
          expect(v["TOTAL"]["CAL_4"]).to match_array ["SMD_Req_yes1"]
          expect(v["TOTAL"]["QM"]).to match_array ["SMD_Req_qm1", "SMD_Second_qm2"]
          expect(v["TOTAL"]["not_set"]).to match_array ["SMD_Req_notset1"]
          expect(v["SMD_Req"]["all"]).to match_array ["SMD_Req_qm1", "SMD_Req_notset1", "SMD_Req_cal1", "SMD_Req_yes1"]
          expect(v["SMD_Req"]["CAL_1"]).to match_array ["SMD_Req_cal1"]
          expect(v["SMD_Req"]["CAL_4"]).to match_array ["SMD_Req_yes1"]
          expect(v["SMD_Req"]["QM"]).to match_array ["SMD_Req_qm1"]
          expect(v["SMD_Req"]["not_set"]).to match_array ["SMD_Req_notset1"]
          expect(v["SMD_Second"]["all"]).to match_array ["SMD_Second_qm2"]
          expect(v["SMD_Second"]["CAL_1"]).to match_array []
          expect(v["SMD_Second"]["CAL_1"]).to match_array []
          expect(v["SMD_Second"]["QM"]).to match_array ["SMD_Second_qm2"]
          expect(v["SMD_Second"]["not_set"]).to match_array []
        end
      end
    end

    context 'security table' do
      table_desc = "type = spec / unit |br| developer = Abc AG |br| status = valid"
      context 'with no data' do
        before(:all) do
          @test = Test.new("tr_module_security_none")
          @test.run
        end
        it 'shall display an appropriate note instead of an empty table', doc_refs: ['DoxTrace_HTML_TraceabilityReportModule'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_module_security_none", "report.html")
          expect(data.tr_nodata?("Cyber Security")).to be true
          expect(data.tr_desc("Cyber Security")).to include table_desc
        end
      end

      context 'with all data filtered out' do
        before(:all) do
          @test = Test.new("tr_module_security_empty")
          @test.run
        end
        it 'shall display an appropriate note instead of an empty table', doc_refs: ['DoxTrace_HTML_TraceabilityReportModule'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_module_security_empty", "report.html")
          expect(data.tr_nodata?("Cyber Security")).to be true
          expect(data.tr_desc("Cyber Security")).to include table_desc
        end
      end

      context 'with valid data' do
        before(:all) do
          @test = Test.new("tr_module_security_table")
          @test.run
        end
        it 'shall contain correct data with module/value pairs including TOTAL and links', doc_refs: ['DoxTrace_HTML_TraceabilityReportModule'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_module_security_table", "report.html")
          expect(data.tr_nodata?("Cyber Security")).to be false
          expect(data.tr_desc("Cyber Security")).to include table_desc

          v = data.tr_values("Cyber Security")

          expect(v["TOTAL"]["all"]).to match_array ["SMD_Req_no1", "SMD_Req_notset1", "SMD_Req_yes1", "SMD_Req_yes2", "SMD_Second_no2"]
          expect(v["TOTAL"]["yes"]).to match_array ["SMD_Req_yes1", "SMD_Req_yes2"]
          expect(v["TOTAL"]["no"]).to match_array ["SMD_Req_no1", "SMD_Second_no2"]
          expect(v["TOTAL"]["not_set"]).to match_array ["SMD_Req_notset1"]
          expect(v["SMD_Req"]["all"]).to match_array ["SMD_Req_no1", "SMD_Req_notset1", "SMD_Req_yes1", "SMD_Req_yes2"]
          expect(v["SMD_Req"]["yes"]).to match_array ["SMD_Req_yes1", "SMD_Req_yes2"]
          expect(v["SMD_Req"]["no"]).to match_array ["SMD_Req_no1"]
          expect(v["SMD_Req"]["not_set"]).to match_array ["SMD_Req_notset1"]
          expect(v["SMD_Second"]["all"]).to match_array ["SMD_Second_no2"]
          expect(v["SMD_Second"]["yes"]).to match_array []
          expect(v["SMD_Second"]["no"]).to match_array ["SMD_Second_no2"]
          expect(v["SMD_Second"]["not_set"]).to match_array []
        end
      end
    end

    context 'referenced/derived table' do
      table_desc_deprecated = "type = spec / interface / unit |br| developer = Abc AG |br| status = valid"
      table_desc = "type = spec / unit |br| developer = Abc AG |br| status = valid"
      context 'with no data' do
        before(:all) do
          @test = Test.new("tr_module_ref_none")
          @test.run
        end
        it 'shall display an appropriate note instead of an empty table', doc_refs: ['DoxTrace_HTML_TraceabilityReportModule'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_module_ref_none", "report.html")
          expect(data.tr_nodata?("Upstream and Downstream")).to be true
          expect(data.tr_desc("Upstream and Downstream")).to include table_desc
        end
      end

      context 'with all data filtered out' do
        before(:all) do
          @test = Test.new("tr_module_ref_empty")
          @test.run
        end
        it 'shall display an appropriate note instead of an empty table', doc_refs: ['DoxTrace_HTML_TraceabilityReportModule'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_module_ref_empty", "report.html")
          expect(data.tr_nodata?("Upstream and Downstream")).to be true
          expect(data.tr_desc("Upstream and Downstream")).to include table_desc_deprecated
        end
      end

      context 'with valid data' do
        before(:all) do
          @test = Test.new("tr_module_ref_table")
          @test.run
        end
        it 'shall contain correct data with module/value pairs including TOTAL and links', doc_refs: ['DoxTrace_HTML_TraceabilityReportModule'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_module_ref_table", "report.html")
          expect(data.tr_nodata?("Upstream and Downstream")).to be false
          expect(data.tr_desc("Upstream and Downstream")).to include table_desc_deprecated

          v = data.tr_values("Upstream and Downstream")

          expect(v["TOTAL"]["all"]).to match_array [ "SMD_Req_deref1", "SMD_Req_deref2", "SMD_Req_deref3", "SMD_Req_deref4",
            "SMD_Level_all", "SMD_Level_input", "SMD_Level_none", "SMD_Level_smd", "SMD_Level_software", "SMD_Level_srs", "SMD_Level_swa",
            "SMD_Req_no1", "SMD_Second_ref1", "SMD_Parent_smd", "SMD_Req_refderef1", "SMD_Req_refderef2"]
          expect(v["TOTAL"]["Downstream Sufficient"]).to match_array ["SMD_Parent_smd", "SMD_Req_deref1", "SMD_Req_deref2", "SMD_Req_deref3", "SMD_Req_deref4", "SMD_Req_refderef1", "SMD_Req_refderef2"]
          expect(v["TOTAL"]["Downstream Missing"]).to match_array [ "SMD_Level_all", "SMD_Level_input", "SMD_Level_none", "SMD_Level_smd", "SMD_Level_software", "SMD_Level_srs", "SMD_Level_swa", "SMD_Second_ref1", "SMD_Req_no1"]
          expect(v["TOTAL"]["Upstream Sufficient"]).to match_array ["SMD_Second_ref1", "SMD_Req_refderef1", "SMD_Req_refderef2", "SMD_Level_all", "SMD_Level_smd", "SMD_Level_swa"]
          expect(v["TOTAL"]["Upstream Missing"]).to match_array ["SMD_Parent_smd", "SMD_Req_deref1", "SMD_Req_deref2", "SMD_Req_deref3", "SMD_Req_deref4", "SMD_Req_no1", "SMD_Level_none", "SMD_Level_input", "SMD_Level_software", "SMD_Level_srs"]

          expect(v["SMD_Req"]["all"]).to match_array ["SMD_Req_deref1", "SMD_Req_deref2", "SMD_Req_deref3", "SMD_Req_deref4", "SMD_Req_no1", "SMD_Req_refderef1", "SMD_Req_refderef2"]
          expect(v["SMD_Req"]["Downstream Sufficient"]).to match_array ["SMD_Req_deref1", "SMD_Req_deref2", "SMD_Req_deref3", "SMD_Req_deref4", "SMD_Req_refderef1", "SMD_Req_refderef2"]
          expect(v["SMD_Req"]["Downstream Missing"]).to match_array ["SMD_Req_no1"]
          expect(v["SMD_Req"]["Upstream Sufficient"]).to match_array ["SMD_Req_refderef1", "SMD_Req_refderef2"]
          expect(v["SMD_Req"]["Upstream Missing"]).to match_array ["SMD_Req_deref1", "SMD_Req_deref2", "SMD_Req_deref3", "SMD_Req_deref4", "SMD_Req_no1"]

          expect(v["SMD_Second"]["all"]).to match_array ["SMD_Second_ref1"]
          expect(v["SMD_Second"]["Downstream Sufficient"]).to match_array []
          expect(v["SMD_Second"]["Downstream Missing"]).to match_array ["SMD_Second_ref1"]
          expect(v["SMD_Second"]["Upstream Sufficient"]).to match_array ["SMD_Second_ref1"]
          expect(v["SMD_Second"]["Upstream Missing"]).to match_array []

          expect(v["SMD_Parent"]["all"]).to match_array ["SMD_Parent_smd"]
          expect(v["SMD_Parent"]["Downstream Sufficient"]).to match_array ["SMD_Parent_smd"]
          expect(v["SMD_Parent"]["Downstream Missing"]).to match_array []
          expect(v["SMD_Parent"]["Upstream Sufficient"]).to match_array []
          expect(v["SMD_Parent"]["Upstream Missing"]).to match_array ["SMD_Parent_smd"]

          expect(v["SMD_Level"]["all"]).to match_array ["SMD_Level_all", "SMD_Level_input", "SMD_Level_none", "SMD_Level_smd", "SMD_Level_software", "SMD_Level_srs", "SMD_Level_swa"]
          expect(v["SMD_Level"]["Downstream Sufficient"]).to match_array []
          expect(v["SMD_Level"]["Downstream Missing"]).to match_array ["SMD_Level_all", "SMD_Level_input", "SMD_Level_none", "SMD_Level_smd", "SMD_Level_software", "SMD_Level_srs", "SMD_Level_swa"]
          expect(v["SMD_Level"]["Upstream Sufficient"]).to match_array ["SMD_Level_all", "SMD_Level_smd", "SMD_Level_swa"]
          expect(v["SMD_Level"]["Upstream Missing"]).to match_array ["SMD_Level_input", "SMD_Level_none", "SMD_Level_software", "SMD_Level_srs"]
        end
      end
    end

    context 'list of specifications' do
      table_desc_deprecated = "type = spec / interface / unit |br| developer = Abc AG |br| status = valid"
      table_desc = "type = spec / unit |br| developer = Abc AG |br| status = valid"

      context 'with no data' do
        before(:all) do
          @test = Test.new("tr_module_list_none")
          @test.run
        end
        it 'shall display an appropriate note instead of an empty table', doc_refs: ['DoxTrace_HTML_TraceabilityReportModule'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_module_ref_none", "report.html")
          expect(data.tr_nodata?("List of Specifications")).to be true
          expect(data.tr_desc("List of Specifications")).to include table_desc
        end
      end

      context 'with all data filtered out' do
        before(:all) do
          @test = Test.new("tr_module_list_empty")
          @test.run
        end
        it 'shall display an appropriate note instead of an empty table', doc_refs: ['DoxTrace_HTML_TraceabilityReportModule'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_module_ref_empty", "report.html")
          expect(data.tr_nodata?("List of Specifications")).to be true
          expect(data.tr_desc("List of Specifications")).to include table_desc_deprecated
        end
      end

      context 'with valid data' do
        before(:all) do
          @test = Test.new("tr_module_list_table")
          @test.run
        end
        it 'shall contain correct data with module/value pairs including TOTAL and links', doc_refs: ['DoxTrace_HTML_TraceabilityReportModule'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_module_list_table", "report.html")
          expect(data.tr_nodata?("List of Specifications")).to be false
          expect(data.tr_desc("List of Specifications")).to include table_desc_deprecated

          v = data.tr_list("List of Specifications")
          expect(v.length). to be 10

          table = {
                   "SMD_Req_AbcccccccccccccccccccccccccccccccccccxAbcccc123xA-1" =>   {"mod" => "SMD_Req",    "Downstream" => "SMD_Req_AbcccccccccccxAbcccc123xA-2, AbccccccccccccccccccccccccccccccccccxAbcccc123xA.txt", "Upstream" => "[missing]"},
                   "SMD_Req_AbcccccccccccxAbcccc123xA-2" =>                           {"mod" => "SMD_Req",    "Downstream" => "[missing]",                                                                                 "Upstream" => "SMD_Req_AbcccccccccccccccccccccccccccccccccccxAbcccc123xA-1"},
                   "SMD_Req_deref1" =>    {"mod" => "SMD_Req",    "Downstream" => "SMD_Req_refderef1, SMD_Req_refderef2, SMD_Second_ref1", "Upstream" => "[missing]"},
                   "SMD_Req_deref2" =>    {"mod" => "SMD_Req",    "Downstream" => "SMD_Req_notset2, index.rst, second.rst",                "Upstream" => "[missing]"},
                   "SMD_Req_deref3" =>    {"mod" => "SMD_Req",    "Downstream" => "index.rst",                                             "Upstream" => "[missing]"},
                   "SMD_Req_deref4" =>    {"mod" => "SMD_Req",    "Downstream" => "invalid_ref",                                           "Upstream" => "[missing]"},
                   "SMD_Req_no1" =>       {"mod" => "SMD_Req",    "Downstream" => "[missing]",                                             "Upstream" => "[missing]"},
                   "SMD_Req_refderef1" => {"mod" => "SMD_Req",    "Downstream" => "SMD_Req_refderef2",                                     "Upstream" => "SMD_Req_deref1, SMD_Req_notset3, SRS_Req_info1"},
                   "SMD_Req_refderef2" => {"mod" => "SMD_Req",    "Downstream" => "SMD_Req_notset2",                                       "Upstream" => "SMD_Req_deref1, SMD_Req_refderef1"},
                   "SMD_Second_ref1" =>   {"mod" => "SMD_Second", "Downstream" => "[missing]",                                             "Upstream" => "SMD_Req_deref1"}}
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
