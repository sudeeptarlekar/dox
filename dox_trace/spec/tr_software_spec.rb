require_relative 'framework/helper'

module Sphinx
  describe "The traceability report for software requirements" do

    context 'status table' do
      table_desc = "type = requirement / srs |br| developer = Abc AG"
      context 'with no data' do
        before(:all) do
          @test = Test.new("tr_software_status_none")
          @test.run
        end
        it 'shall display an appropriate note instead of an empty table', doc_refs: ['DoxTrace_HTML_TraceabilityReportSoftware'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_software_status_none", "report.html")
          expect(data.tr_nodata?("Status")).to be true
          expect(data.tr_desc("Status")).to include table_desc
        end
      end

      context 'with all data filtered out' do
        before(:all) do
          @test = Test.new("tr_software_status_empty")
          @test.run
        end
        it 'shall display an appropriate note instead of an empty table', doc_refs: ['DoxTrace_HTML_TraceabilityReportSoftware'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_software_status_empty", "report.html")
          expect(data.tr_nodata?("Status")).to be true
          expect(data.tr_desc("Status")).to include table_desc
        end
      end

      context 'with valid data' do
        before(:all) do
          @test = Test.new("tr_software_status_table")
          @test.run
        end
        it 'shall contain correct data with module/value pairs including TOTAL and links', doc_refs: ['DoxTrace_HTML_TraceabilityReportSoftware'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_software_status_table", "report.html")
          expect(data.tr_nodata?("Status")).to be false
          expect(data.tr_desc("Status")).to include table_desc

          v = data.tr_values("Status")

          expect(v["TOTAL"]["all"]).to match_array ["SRS_Req_valid1", "SRS_Req_valid2", "SRS_Req_valid3", "SRS_Req_draft1", "SRS_Req_draft2", "SRS_Req_invalid1"]
          expect(v["TOTAL"]["valid"]).to match_array ["SRS_Req_valid1", "SRS_Req_valid2", "SRS_Req_valid3"]
          expect(v["TOTAL"]["draft"]).to match_array ["SRS_Req_draft1", "SRS_Req_draft2"]
          expect(v["TOTAL"]["invalid"]).to match_array ["SRS_Req_invalid1"]
          expect(v["Heading"]["all"]).to match_array ["SRS_Req_valid1", "SRS_Req_valid2", "SRS_Req_draft2"]
          expect(v["Heading"]["valid"]).to match_array ["SRS_Req_valid1", "SRS_Req_valid2"]
          expect(v["Heading"]["draft"]).to match_array ["SRS_Req_draft2"]
          expect(v["Heading"]["invalid"]).to match_array []
          expect(v["SRS_Req"]["all"]).to match_array ["SRS_Req_draft1", "SRS_Req_invalid1"]
          expect(v["SRS_Req"]["valid"]).to match_array []
          expect(v["SRS_Req"]["draft"]).to match_array ["SRS_Req_draft1"]
          expect(v["SRS_Req"]["invalid"]).to match_array ["SRS_Req_invalid1"]
          expect(v["Second Document"]["all"]).to match_array ["SRS_Req_valid3"]
          expect(v["Second Document"]["valid"]).to match_array ["SRS_Req_valid3"]
          expect(v["Second Document"]["draft"]).to match_array []
          expect(v["Second Document"]["invalid"]).to match_array []
        end
      end
    end

    context 'safety table' do
      table_desc = "type = requirement / srs |br| developer = Abc AG |br| status = valid"
      context 'with no data' do
        before(:all) do
          @test = Test.new("tr_software_safety_none")
          @test.run
        end
        it 'shall display an appropriate note instead of an empty table', doc_refs: ['DoxTrace_HTML_TraceabilityReportSoftware'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_software_safety_none", "report.html")
          expect(data.tr_nodata?("Functional Safety")).to be true
          expect(data.tr_desc("Functional Safety")).to include table_desc
        end
      end

      context 'with all data filtered out' do
        before(:all) do
          @test = Test.new("tr_software_safety_empty")
          @test.run
        end
        it 'shall display an appropriate note instead of an empty table', doc_refs: ['DoxTrace_HTML_TraceabilityReportSoftware'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_software_safety_empty", "report.html")
          expect(data.tr_nodata?("Functional Safety")).to be true
          expect(data.tr_desc("Functional Safety")).to include table_desc
        end
      end

      context 'with valid data' do
        before(:all) do
          @test = Test.new("tr_software_safety_table")
          @test.run
        end
        it 'shall contain correct data with module/value pairs including TOTAL and links', doc_refs: ['DoxTrace_HTML_TraceabilityReportSoftware'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_software_safety_table", "report.html")
          expect(data.tr_nodata?("Functional Safety")).to be false
          expect(data.tr_desc("Functional Safety")).to include table_desc

          v = data.tr_values("Functional Safety")

          expect(v["TOTAL"]["all"]).to match_array ["SRS_Req_A1", "SRS_Req_A2", "SRS_Req_B(C)1", "SRS_Req_notset1", "SRS_Second_QM"]
          expect(v["TOTAL"]["ASIL_A"]).to match_array ["SRS_Req_A1", "SRS_Req_A2"]
          expect(v["TOTAL"]["ASIL_B(C)"]).to match_array ["SRS_Req_B(C)1"]
          expect(v["TOTAL"]["QM"]).to match_array ["SRS_Second_QM"]
          expect(v["TOTAL"]["not_set"]).to match_array ["SRS_Req_notset1"]
          expect(v["SRS_Req"]["all"]).to match_array ["SRS_Req_B(C)1", "SRS_Req_notset1"]
          expect(v["SRS_Req"]["ASIL_A"]).to match_array []
          expect(v["SRS_Req"]["ASIL_B(C)"]).to match_array ["SRS_Req_B(C)1"]
          expect(v["SRS_Req"]["QM"]).to match_array []
          expect(v["SRS_Req"]["not_set"]).to match_array ["SRS_Req_notset1"]
          expect(v["Heading"]["all"]).to match_array ["SRS_Req_A1", "SRS_Req_A2"]
          expect(v["Heading"]["ASIL_A"]).to match_array ["SRS_Req_A1", "SRS_Req_A2"]
          expect(v["Heading"]["ASIL_B(C)"]).to match_array []
          expect(v["Heading"]["QM"]).to match_array []
          expect(v["Heading"]["not_set"]).to match_array []
          expect(v["Second Document"]["all"]).to match_array ["SRS_Second_QM"]
          expect(v["Second Document"]["ASIL_A"]).to match_array []
          expect(v["Second Document"]["ASIL_B(C)"]).to match_array []
          expect(v["Second Document"]["QM"]).to match_array ["SRS_Second_QM"]
          expect(v["Second Document"]["not_set"]).to match_array []
        end
      end
    end

    context 'cal table' do
      table_desc = "type = requirement / srs |br| developer = Abc AG |br| status = valid"
      context 'with no data' do
        before(:all) do
          @test = Test.new("tr_software_cal_none")
          @test.run
        end
        it 'shall display an appropriate note instead of an empty table', doc_refs: ['DoxTrace_HTML_TraceabilityReportSoftware'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_software_cal_none", "report.html")
          expect(data.tr_nodata?("Cyber Security")).to be true
          expect(data.tr_desc("Cyber Security")).to include table_desc
        end
      end

      context 'with all data filtered out' do
        before(:all) do
          @test = Test.new("tr_software_cal_empty")
          @test.run
        end
        it 'shall display an appropriate note instead of an empty table', doc_refs: ['DoxTrace_HTML_TraceabilityReportSoftware'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_software_cal_empty", "report.html")
          expect(data.tr_nodata?("Cyber Security")).to be true
          expect(data.tr_desc("Cyber Security")).to include table_desc
        end
      end

      context 'with valid data' do
        before(:all) do
          @test = Test.new("tr_software_cal_table")
          @test.run
        end
        it 'shall contain correct data with module/value pairs including TOTAL and links', doc_refs: ['DoxTrace_HTML_TraceabilityReportSoftware'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_software_cal_table", "report.html")
          expect(data.tr_nodata?("Cyber Security")).to be false
          expect(data.tr_desc("Cyber Security")).to include table_desc

          v = data.tr_values("Cyber Security")

          expect(v["TOTAL"]["all"]).to match_array ["SRS_Req_qm1", "SRS_Req_notset1", "SRS_Req_cal1", "SRS_Req_yes1", "SRS_Second_qm2"]
          expect(v["TOTAL"]["CAL_1"]).to match_array ["SRS_Req_cal1"]
          expect(v["TOTAL"]["CAL_4"]).to match_array ["SRS_Req_yes1"]
          expect(v["TOTAL"]["QM"]).to match_array ["SRS_Req_qm1", "SRS_Second_qm2"]
          expect(v["TOTAL"]["not_set"]).to match_array ["SRS_Req_notset1"]
          expect(v["SRS_Req"]["all"]).to match_array ["SRS_Req_qm1", "SRS_Req_notset1"]
          expect(v["SRS_Req"]["CAL_1"]).to match_array []
          expect(v["SRS_Req"]["CAL_4"]).to match_array []
          expect(v["SRS_Req"]["QM"]).to match_array ["SRS_Req_qm1"]
          expect(v["SRS_Req"]["not_set"]).to match_array ["SRS_Req_notset1"]
          expect(v["Heading"]["all"]).to match_array ["SRS_Req_cal1", "SRS_Req_yes1"]
          expect(v["Heading"]["CAL_1"]).to match_array ["SRS_Req_cal1"]
          expect(v["Heading"]["CAL_4"]).to match_array ["SRS_Req_yes1"]
          expect(v["Heading"]["QM"]).to match_array []
          expect(v["Heading"]["not_set"]).to match_array []
          expect(v["Second Document"]["all"]).to match_array ["SRS_Second_qm2"]
          expect(v["Second Document"]["CAL_1"]).to match_array []
          expect(v["Second Document"]["CAL_4"]).to match_array []
          expect(v["Second Document"]["QM"]).to match_array ["SRS_Second_qm2"]
          expect(v["Second Document"]["not_set"]).to match_array []
        end
      end
    end

    context 'security table' do
      table_desc = "type = requirement / srs |br| developer = Abc AG |br| status = valid"
      context 'with no data' do
        before(:all) do
          @test = Test.new("tr_software_security_none")
          @test.run
        end
        it 'shall display an appropriate note instead of an empty table', doc_refs: ['DoxTrace_HTML_TraceabilityReportSoftware'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_software_security_none", "report.html")
          expect(data.tr_nodata?("Cyber Security")).to be true
          expect(data.tr_desc("Cyber Security")).to include table_desc
        end
      end

      context 'with all data filtered out' do
        before(:all) do
          @test = Test.new("tr_software_security_empty")
          @test.run
        end
        it 'shall display an appropriate note instead of an empty table', doc_refs: ['DoxTrace_HTML_TraceabilityReportSoftware'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_software_security_empty", "report.html")
          expect(data.tr_nodata?("Cyber Security")).to be true
          expect(data.tr_desc("Cyber Security")).to include table_desc
        end
      end

      context 'with valid data' do
        before(:all) do
          @test = Test.new("tr_software_security_table")
          @test.run
        end
        it 'shall contain correct data with module/value pairs including TOTAL and links', doc_refs: ['DoxTrace_HTML_TraceabilityReportSoftware'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_software_security_table", "report.html")
          expect(data.tr_nodata?("Cyber Security")).to be false
          expect(data.tr_desc("Cyber Security")).to include table_desc

          v = data.tr_values("Cyber Security")

          expect(v["TOTAL"]["all"]).to match_array ["SRS_Req_no1", "SRS_Req_notset1", "SRS_Req_yes1", "SRS_Req_yes2", "SRS_Second_no2"]
          expect(v["TOTAL"]["yes"]).to match_array ["SRS_Req_yes1", "SRS_Req_yes2"]
          expect(v["TOTAL"]["no"]).to match_array ["SRS_Req_no1", "SRS_Second_no2"]
          expect(v["TOTAL"]["not_set"]).to match_array ["SRS_Req_notset1"]
          expect(v["SRS_Req"]["all"]).to match_array ["SRS_Req_no1", "SRS_Req_notset1"]
          expect(v["SRS_Req"]["yes"]).to match_array []
          expect(v["SRS_Req"]["no"]).to match_array ["SRS_Req_no1"]
          expect(v["SRS_Req"]["not_set"]).to match_array ["SRS_Req_notset1"]
          expect(v["Heading"]["all"]).to match_array ["SRS_Req_yes1", "SRS_Req_yes2"]
          expect(v["Heading"]["yes"]).to match_array ["SRS_Req_yes1", "SRS_Req_yes2"]
          expect(v["Heading"]["no"]).to match_array []
          expect(v["Heading"]["not_set"]).to match_array []
          expect(v["Second Document"]["all"]).to match_array ["SRS_Second_no2"]
          expect(v["Second Document"]["yes"]).to match_array []
          expect(v["Second Document"]["no"]).to match_array ["SRS_Second_no2"]
          expect(v["Second Document"]["not_set"]).to match_array []
        end
      end
    end

    context 'referenced/derived table' do
      table_desc = "type = requirement / srs |br| developer = Abc AG |br| status = valid"
      context 'with no data' do
        before(:all) do
          @test = Test.new("tr_software_ref_none")
          @test.run
        end
        it 'shall display an appropriate note instead of an empty table', doc_refs: ['DoxTrace_HTML_TraceabilityReportSoftware'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_software_ref_none", "report.html")
          expect(data.tr_nodata?("Upstream and Downstream")).to be true
          expect(data.tr_desc("Upstream and Downstream")).to include table_desc
        end
      end

      context 'with all data filtered out' do
        before(:all) do
          @test = Test.new("tr_software_ref_empty")
          @test.run
        end
        it 'shall display an appropriate note instead of an empty table', doc_refs: ['DoxTrace_HTML_TraceabilityReportSoftware'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_software_ref_empty", "report.html")
          expect(data.tr_nodata?("Upstream and Downstream")).to be true
          expect(data.tr_desc("Upstream and Downstream")).to include table_desc
        end
      end

      context 'with valid data' do
        before(:all) do
          @test = Test.new("tr_software_ref_table")
          @test.run
        end
        it 'shall contain correct data with module/value pairs including TOTAL and links', doc_refs: ['DoxTrace_HTML_TraceabilityReportSoftware'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_software_ref_table", "report.html")
          expect(data.tr_nodata?("Upstream and Downstream")).to be false
          expect(data.tr_desc("Upstream and Downstream")).to include table_desc

          v = data.tr_values("Upstream and Downstream")

          expect(v["TOTAL"]["all"]).to match_array ["SRS_Req_deref1", "SRS_Req_refderef1", "SRS_Req_refderef2", "SRS_Req_deref2", "SRS_Req_deref3", "SRS_Req_ref1"]
          expect(v["TOTAL"]["Downstream Sufficient"]).to match_array ["SRS_Req_deref1", "SRS_Req_refderef1", "SRS_Req_refderef2", "SRS_Req_deref2", "SRS_Req_deref3"]
          expect(v["TOTAL"]["Downstream Missing"]).to match_array ["SRS_Req_ref1"]
          expect(v["TOTAL"]["Upstream Sufficient"]).to match_array ["SRS_Req_refderef1", "SRS_Req_refderef2", "SRS_Req_ref1"]
          expect(v["TOTAL"]["Upstream Missing"]).to match_array ["SRS_Req_deref1", "SRS_Req_deref2", "SRS_Req_deref3"]
          expect(v["Heading"]["all"]).to match_array ["SRS_Req_deref1", "SRS_Req_refderef2"]
          expect(v["Heading"]["Downstream Sufficient"]).to match_array ["SRS_Req_deref1", "SRS_Req_refderef2"]
          expect(v["Heading"]["Downstream Missing"]).to match_array []
          expect(v["Heading"]["Upstream Sufficient"]).to match_array ["SRS_Req_refderef2"]
          expect(v["Heading"]["Upstream Missing"]).to match_array ["SRS_Req_deref1"]
          expect(v["SRS_Req"]["all"]).to match_array ["SRS_Req_refderef1", "SRS_Req_deref2", "SRS_Req_deref3"]
          expect(v["SRS_Req"]["Downstream Sufficient"]).to match_array ["SRS_Req_refderef1", "SRS_Req_deref2", "SRS_Req_deref3"]
          expect(v["SRS_Req"]["Downstream Missing"]).to match_array []
          expect(v["SRS_Req"]["Upstream Sufficient"]).to match_array ["SRS_Req_refderef1"]
          expect(v["SRS_Req"]["Upstream Missing"]).to match_array ["SRS_Req_deref2", "SRS_Req_deref3"]
          expect(v["Second Document"]["all"]).to match_array ["SRS_Req_ref1"]
          expect(v["Second Document"]["Downstream Sufficient"]).to match_array []
          expect(v["Second Document"]["Downstream Missing"]).to match_array ["SRS_Req_ref1"]
          expect(v["Second Document"]["Upstream Sufficient"]).to match_array ["SRS_Req_ref1"]
          expect(v["Second Document"]["Upstream Missing"]).to match_array []
        end
      end
    end

    context 'list of requirements' do
      table_desc = "type = requirement / srs |br| developer = Abc AG |br| status = valid"
      context 'with no data' do
        before(:all) do
          @test = Test.new("tr_software_list_none")
          @test.run
        end
        it 'shall display an appropriate note instead of an empty table', doc_refs: ['DoxTrace_HTML_TraceabilityReportSoftware'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_software_ref_none", "report.html")
          expect(data.tr_nodata?("List of Requirements")).to be true
          expect(data.tr_desc("List of Requirements")).to include table_desc
        end
      end

      context 'with all data filtered out' do
        before(:all) do
          @test = Test.new("tr_software_list_empty")
          @test.run
        end
        it 'shall display an appropriate note instead of an empty table', doc_refs: ['DoxTrace_HTML_TraceabilityReportSoftware'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_software_ref_empty", "report.html")
          expect(data.tr_nodata?("List of Requirements")).to be true
          expect(data.tr_desc("List of Requirements")).to include table_desc
        end
      end

      context 'with valid data' do
        before(:all) do
          @test = Test.new("tr_software_list_table")
          @test.run
        end
        it 'shall contain correct data with module/value pairs including TOTAL and links', doc_refs: ['DoxTrace_HTML_TraceabilityReportSoftware'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_software_list_table", "report.html")
          expect(data.tr_nodata?("List of Requirements")).to be false
          expect(data.tr_desc("List of Requirements")).to include table_desc

          v = data.tr_list("List of Requirements")
          expect(v.length). to be 6

          table = {"SRS_Req_deref1" =>    {"mod" => "Heading",         "Downstream" => "SRS_Req_ref1, SRS_Req_refderef1, SRS_Req_refderef2", "Upstream" => "[missing]"},
                   "SRS_Req_refderef1" => {"mod" => "SRS_Req",         "Downstream" => "SRS_Req_refderef2",                                  "Upstream" => "SRS_Req_deref1"},
                   "SRS_Req_refderef2" => {"mod" => "Heading",         "Downstream" => "SRS_Req_notset2",                                    "Upstream" => "SRS_Req_deref1, SRS_Req_refderef1"},
                   "SRS_Req_deref2" =>    {"mod" => "SRS_Req",         "Downstream" => "-",                                                  "Upstream" => "[missing]"},
                   "SRS_Req_deref3" =>    {"mod" => "SRS_Req",         "Downstream" => "SRS_Req_notset2, index.rst, second.rst",             "Upstream" => "[missing]"},
                   "SRS_Req_ref1" =>      {"mod" => "Second Document", "Downstream" => "[missing]",                                          "Upstream" => "SRS_Req_deref1"}}
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
