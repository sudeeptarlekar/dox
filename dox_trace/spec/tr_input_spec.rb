require_relative 'framework/helper'

module Sphinx
  describe "The traceability report for input requirements" do

    context 'developer table' do
      table_desc = "type = requirement"
      context 'with no data' do
        before(:all) do
          @test = Test.new("tr_input_dev_none")
          @test.run
        end
        it 'shall display an appropriate note instead of an empty table', doc_refs: ['DoxTrace_HTML_TraceabilityReportInput'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_input_dev_none", "report.html")
          expect(data.tr_nodata?("Developer")).to be true
          expect(data.tr_desc("Developer")).to include table_desc
        end
      end

      context 'developer table with valid data' do
        before(:all) do
          @test = Test.new("tr_input_dev_table")
          @test.run
        end
        it 'shall contain correct data with module/value pairs including TOTAL and links', doc_refs: ['DoxTrace_HTML_TraceabilityReportInput'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_input_dev_table", "report.html")
          expect(data.tr_nodata?("Developer")).to be false
          expect(data.tr_desc("Developer")).to include table_desc

          v = data.tr_values("Developer")
          expect(v["TOTAL"]["all"]).to match_array ["CRS_Req_notset1", "CRS_Req_notset2", "CRS_Req_notset3", "CRS_Req_abc1", "CRS_Req_abc2", "CRS_Req_other1", "CRS_Req_abcother1"]
          expect(v["TOTAL"]["Abc AG"]).to match_array ["CRS_Req_abc1", "CRS_Req_abc2", "CRS_Req_abcother1"]
          expect(v["TOTAL"]["other"]).to match_array ["CRS_Req_other1", "CRS_Req_abcother1"]
          expect(v["TOTAL"]["not set"]).to match_array ["CRS_Req_notset1", "CRS_Req_notset2", "CRS_Req_notset3"]
          expect(v["Heading"]["all"]).to match_array ["CRS_Req_notset1", "CRS_Req_notset2", "CRS_Req_notset3"]
          expect(v["Heading"]["Abc AG"]).to match_array []
          expect(v["Heading"]["other"]).to match_array []
          expect(v["Heading"]["not set"]).to match_array ["CRS_Req_notset1", "CRS_Req_notset2", "CRS_Req_notset3"]
          expect(v["Second Document"]["all"]).to match_array ["CRS_Req_abc1", "CRS_Req_abc2", "CRS_Req_other1", "CRS_Req_abcother1"]
          expect(v["Second Document"]["Abc AG"]).to match_array ["CRS_Req_abc1", "CRS_Req_abc2", "CRS_Req_abcother1"]
          expect(v["Second Document"]["other"]).to match_array ["CRS_Req_other1", "CRS_Req_abcother1"]
          expect(v["Second Document"]["not set"]).to match_array []
        end
      end
    end

    context 'status table' do
      table_desc = "type = requirement |br| developer = Abc AG"
      context 'with no data' do
        before(:all) do
          @test = Test.new("tr_input_status_none")
          @test.run
        end
        it 'shall display an appropriate note instead of an empty table', doc_refs: ['DoxTrace_HTML_TraceabilityReportInput'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_input_status_none", "report.html")
          expect(data.tr_nodata?("Status")).to be true
          expect(data.tr_desc("Status")).to include table_desc
        end
      end

      context 'with all data filtered out' do
        before(:all) do
          @test = Test.new("tr_input_status_empty")
          @test.run
        end
        it 'shall display an appropriate note instead of an empty table', doc_refs: ['DoxTrace_HTML_TraceabilityReportInput'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_input_status_empty", "report.html")
          expect(data.tr_nodata?("Status")).to be true
          expect(data.tr_desc("Status")).to include table_desc
        end
      end

      context 'with valid data' do
        before(:all) do
          @test = Test.new("tr_input_status_table")
          @test.run
        end
        it 'shall contain correct data with module/value pairs including TOTAL and links', doc_refs: ['DoxTrace_HTML_TraceabilityReportInput'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_input_status_table", "report.html")
          expect(data.tr_nodata?("Status")).to be false
          expect(data.tr_desc("Status")).to include table_desc

          v = data.tr_values("Status")

          expect(v["TOTAL"]["all"]).to match_array ["CRS_Req_valid1", "CRS_Req_valid2", "CRS_Req_valid3", "CRS_Req_draft1", "CRS_Req_draft2", "CRS_Req_invalid1"]
          expect(v["TOTAL"]["valid"]).to match_array ["CRS_Req_valid1", "CRS_Req_valid2", "CRS_Req_valid3"]
          expect(v["TOTAL"]["draft"]).to match_array ["CRS_Req_draft1", "CRS_Req_draft2"]
          expect(v["TOTAL"]["invalid"]).to match_array ["CRS_Req_invalid1"]
          expect(v["Heading"]["all"]).to match_array ["CRS_Req_valid1", "CRS_Req_valid2", "CRS_Req_draft1", "CRS_Req_draft2", "CRS_Req_invalid1"]
          expect(v["Heading"]["valid"]).to match_array ["CRS_Req_valid1", "CRS_Req_valid2"]
          expect(v["Heading"]["draft"]).to match_array ["CRS_Req_draft1", "CRS_Req_draft2"]
          expect(v["Heading"]["invalid"]).to match_array ["CRS_Req_invalid1"]
          expect(v["Second Document"]["all"]).to match_array ["CRS_Req_valid3"]
          expect(v["Second Document"]["valid"]).to match_array ["CRS_Req_valid3"]
          expect(v["Second Document"]["draft"]).to match_array []
          expect(v["Second Document"]["invalid"]).to match_array []
        end
      end
    end

    context 'review_status table' do
      table_desc = "type = requirement |br| developer = Abc AG |br| status = valid"
      context 'with no data' do
        before(:all) do
          @test = Test.new("tr_input_reviewstatus_none")
          @test.run
        end
        it 'shall display an appropriate note instead of an empty table', doc_refs: ['DoxTrace_HTML_TraceabilityReportInput'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_input_reviewstatus_none", "report.html")
          expect(data.tr_nodata?("Review Status")).to be true
          expect(data.tr_desc("Review Status")).to include table_desc
        end
      end

      context 'with all data filtered out' do
        before(:all) do
          @test = Test.new("tr_input_reviewstatus_empty")
          @test.run
        end
        it 'shall display an appropriate note instead of an empty table', doc_refs: ['DoxTrace_HTML_TraceabilityReportInput'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_input_reviewstatus_empty", "report.html")
          expect(data.tr_nodata?("Review Status")).to be true
          expect(data.tr_desc("Review Status")).to include table_desc
        end
      end

      context 'with valid data' do
        before(:all) do
          @test = Test.new("tr_input_reviewstatus_table")
          @test.run
        end
        it 'shall contain correct data with module/value pairs including TOTAL and links', doc_refs: ['DoxTrace_HTML_TraceabilityReportInput'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_input_reviewstatus_table", "report.html")
          expect(data.tr_nodata?("Review Status")).to be false
          expect(data.tr_desc("Review Status")).to include table_desc

          v = data.tr_values("Review Status")

          expect(v["TOTAL"]["all"]).to match_array ["CRS_Req_accepted1", "CRS_Req_accepted2", "CRS_Req_accepted3", "CRS_Req_unclear1", "CRS_Req_unclear2", "CRS_Req_rejected1", "CRS_Req_notrelevant1", "CRS_Req_notreviewed1", "CRS_Req_notreviewed2"]
          expect(v["TOTAL"]["accepted"]).to match_array ["CRS_Req_accepted1", "CRS_Req_accepted2", "CRS_Req_accepted3"]
          expect(v["TOTAL"]["unclear"]).to match_array ["CRS_Req_unclear1", "CRS_Req_unclear2"]
          expect(v["TOTAL"]["rejected"]).to match_array ["CRS_Req_rejected1"]
          expect(v["TOTAL"]["not_relevant"]).to match_array ["CRS_Req_notrelevant1"]
          expect(v["TOTAL"]["not_reviewed"]).to match_array ["CRS_Req_notreviewed1", "CRS_Req_notreviewed2"]
          expect(v["Heading"]["all"]).to match_array ["CRS_Req_accepted1", "CRS_Req_accepted2", "CRS_Req_unclear1", "CRS_Req_unclear2", "CRS_Req_rejected1", "CRS_Req_notrelevant1", "CRS_Req_notreviewed1"]
          expect(v["Heading"]["accepted"]).to match_array ["CRS_Req_accepted1", "CRS_Req_accepted2"]
          expect(v["Heading"]["unclear"]).to match_array ["CRS_Req_unclear1", "CRS_Req_unclear2"]
          expect(v["Heading"]["rejected"]).to match_array ["CRS_Req_rejected1"]
          expect(v["Heading"]["not_relevant"]).to match_array ["CRS_Req_notrelevant1"]
          expect(v["Heading"]["not_reviewed"]).to match_array ["CRS_Req_notreviewed1"]
          expect(v["Second Document"]["all"]).to match_array ["CRS_Req_accepted3", "CRS_Req_notreviewed2"]
          expect(v["Second Document"]["accepted"]).to match_array ["CRS_Req_accepted3"]
          expect(v["Second Document"]["unclear"]).to match_array []
          expect(v["Second Document"]["rejected"]).to match_array []
          expect(v["Second Document"]["not_relevant"]).to match_array []
          expect(v["Second Document"]["not_reviewed"]).to match_array ["CRS_Req_notreviewed2"]
        end
      end
    end

    context 'safety table' do
      table_desc = "type = requirement |br| developer = Abc AG |br| status = valid |br| review_status = accepted"
      context 'with no data' do
        before(:all) do
          @test = Test.new("tr_input_safety_none")
          @test.run
        end
        it 'shall display an appropriate note instead of an empty table', doc_refs: ['DoxTrace_HTML_TraceabilityReportInput'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_input_safety_none", "report.html")
          expect(data.tr_nodata?("Functional Safety")).to be true
          expect(data.tr_desc("Functional Safety")).to include table_desc
        end
      end

      context 'with all data filtered out' do
        before(:all) do
          @test = Test.new("tr_input_safety_empty")
          @test.run
        end
        it 'shall display an appropriate note instead of an empty table', doc_refs: ['DoxTrace_HTML_TraceabilityReportInput'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_input_safety_empty", "report.html")
          expect(data.tr_nodata?("Functional Safety")).to be true
          expect(data.tr_desc("Functional Safety")).to include table_desc
        end
      end

      context 'with valid data' do
        before(:all) do
          @test = Test.new("tr_input_safety_table")
          @test.run
        end
        it 'shall contain correct data with module/value pairs including TOTAL and links', doc_refs: ['DoxTrace_HTML_TraceabilityReportInput'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_input_safety_table", "report.html")
          expect(data.tr_nodata?("Functional Safety")).to be false
          expect(data.tr_desc("Functional Safety")).to include table_desc

          v = data.tr_values("Functional Safety")

          expect(v["TOTAL"]["all"]).to match_array ["CRS_Req_A1", "CRS_Req_A2", "CRS_Req_B(C)1", "CRS_Second_QM"]
          expect(v["TOTAL"]["ASIL_A"]).to match_array ["CRS_Req_A1", "CRS_Req_A2"]
          expect(v["TOTAL"]["ASIL_B(C)"]).to match_array ["CRS_Req_B(C)1"]
          expect(v["TOTAL"]["QM"]).to match_array ["CRS_Second_QM"]
          expect(v["TOTAL"]["not_set"]).to match_array []
          expect(v["Heading"]["all"]).to match_array ["CRS_Req_A1", "CRS_Req_A2", "CRS_Req_B(C)1"]
          expect(v["Heading"]["ASIL_A"]).to match_array ["CRS_Req_A1", "CRS_Req_A2"]
          expect(v["Heading"]["ASIL_B(C)"]).to match_array ["CRS_Req_B(C)1"]
          expect(v["Heading"]["QM"]).to match_array []
          expect(v["Heading"]["not_set"]).to match_array []
          expect(v["Second Document"]["all"]).to match_array ["CRS_Second_QM"]
          expect(v["Second Document"]["ASIL_A"]).to match_array []
          expect(v["Second Document"]["ASIL_B(C)"]).to match_array []
          expect(v["Second Document"]["QM"]).to match_array ["CRS_Second_QM"]
          expect(v["Second Document"]["not_set"]).to match_array []
        end
      end
    end

    context 'cal table' do
      table_desc = "type = requirement |br| developer = Abc AG |br| status = valid |br| review_status = accepted"
      context 'with no data' do
        before(:all) do
          @test = Test.new("tr_input_cal_none")
          @test.run
        end
        it 'shall display an appropriate note instead of an empty table', doc_refs: ['DoxTrace_HTML_TraceabilityReportInput'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_input_cal_none", "report.html")
          expect(data.tr_nodata?("Cyber Security")).to be true
          expect(data.tr_desc("Cyber Security")).to include table_desc
        end
      end

      context 'with all data filtered out' do
        before(:all) do
          @test = Test.new("tr_input_cal_empty")
          @test.run
        end
        it 'shall display an appropriate note instead of an empty table', doc_refs: ['DoxTrace_HTML_TraceabilityReportInput'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_input_cal_empty", "report.html")
          expect(data.tr_nodata?("Cyber Security")).to be true
          expect(data.tr_desc("Cyber Security")).to include table_desc
        end
      end

      context 'with valid data' do
        before(:all) do
          @test = Test.new("tr_input_cal_table")
          @test.run
        end
        it 'shall contain correct data with module/value pairs including TOTAL and links', doc_refs: ['DoxTrace_HTML_TraceabilityReportInput'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_input_cal_table", "report.html")
          expect(data.tr_nodata?("Cyber Security")).to be false
          expect(data.tr_desc("Cyber Security")).to include table_desc

          v = data.tr_values("Cyber Security")

          expect(v["TOTAL"]["all"]).to match_array ["CRS_Req_qm1", "CRS_Req_notset1", "CRS_Req_cal1", "CRS_Req_yes1", "CRS_Second_qm2"]
          expect(v["TOTAL"]["CAL_1"]).to match_array ["CRS_Req_cal1"]
          expect(v["TOTAL"]["CAL_4"]).to match_array ["CRS_Req_yes1"]
          expect(v["TOTAL"]["QM"]).to match_array ["CRS_Req_qm1", "CRS_Second_qm2"]
          expect(v["TOTAL"]["not_set"]).to match_array ["CRS_Req_notset1"]
          expect(v["Heading"]["all"]).to match_array ["CRS_Req_qm1", "CRS_Req_notset1", "CRS_Req_cal1", "CRS_Req_yes1"]
          expect(v["Heading"]["CAL_1"]).to match_array ["CRS_Req_cal1"]
          expect(v["Heading"]["CAL_4"]).to match_array ["CRS_Req_yes1"]
          expect(v["Heading"]["QM"]).to match_array ["CRS_Req_qm1"]
          expect(v["Heading"]["not_set"]).to match_array ["CRS_Req_notset1"]
          expect(v["Second Document"]["all"]).to match_array ["CRS_Second_qm2"]
          expect(v["Second Document"]["CAL_1"]).to match_array []
          expect(v["Second Document"]["CAL_4"]).to match_array []
          expect(v["Second Document"]["QM"]).to match_array ["CRS_Second_qm2"]
          expect(v["Second Document"]["not_set"]).to match_array []
        end
      end
    end

    context 'security table' do
      table_desc = "type = requirement |br| developer = Abc AG |br| status = valid |br| review_status = accepted"
      context 'with no data' do
        before(:all) do
          @test = Test.new("tr_input_security_none")
          @test.run
        end
        it 'shall display an appropriate note instead of an empty table', doc_refs: ['DoxTrace_HTML_TraceabilityReportInput'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_input_security_none", "report.html")
          expect(data.tr_nodata?("Cyber Security")).to be true
          expect(data.tr_desc("Cyber Security")).to include table_desc
        end
      end

      context 'with all data filtered out' do
        before(:all) do
          @test = Test.new("tr_input_security_empty")
          @test.run
        end
        it 'shall display an appropriate note instead of an empty table', doc_refs: ['DoxTrace_HTML_TraceabilityReportInput'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_input_security_empty", "report.html")
          expect(data.tr_nodata?("Cyber Security")).to be true
          expect(data.tr_desc("Cyber Security")).to include table_desc
        end
      end

      context 'with valid data' do
        before(:all) do
          @test = Test.new("tr_input_security_table")
          @test.run
        end
        it 'shall contain correct data with module/value pairs including TOTAL and links', doc_refs: ['DoxTrace_HTML_TraceabilityReportInput'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_input_security_table", "report.html")
          expect(data.tr_nodata?("Cyber Security")).to be false
          expect(data.tr_desc("Cyber Security")).to include table_desc

          v = data.tr_values("Cyber Security")

          expect(v["TOTAL"]["all"]).to match_array ["CRS_Req_no1", "CRS_Req_notset1", "CRS_Req_yes1", "CRS_Req_yes2", "CRS_Second_no2"]
          expect(v["TOTAL"]["yes"]).to match_array ["CRS_Req_yes1", "CRS_Req_yes2"]
          expect(v["TOTAL"]["no"]).to match_array ["CRS_Req_no1", "CRS_Second_no2"]
          expect(v["TOTAL"]["not_set"]).to match_array ["CRS_Req_notset1"]
          expect(v["Heading"]["all"]).to match_array ["CRS_Req_no1", "CRS_Req_notset1", "CRS_Req_yes1", "CRS_Req_yes2"]
          expect(v["Heading"]["yes"]).to match_array ["CRS_Req_yes1", "CRS_Req_yes2"]
          expect(v["Heading"]["no"]).to match_array ["CRS_Req_no1"]
          expect(v["Heading"]["not_set"]).to match_array ["CRS_Req_notset1"]
          expect(v["Second Document"]["all"]).to match_array ["CRS_Second_no2"]
          expect(v["Second Document"]["yes"]).to match_array []
          expect(v["Second Document"]["no"]).to match_array ["CRS_Second_no2"]
          expect(v["Second Document"]["not_set"]).to match_array []
        end
      end
    end

    context 'referenced/derived table' do
      table_desc = "type = requirement |br| developer = Abc AG |br| status = valid |br| review_status = accepted"
      context 'with no data' do
        before(:all) do
          @test = Test.new("tr_input_ref_none")
          @test.run
        end
        it 'shall display an appropriate note instead of an empty table', doc_refs: ['DoxTrace_HTML_TraceabilityReportInput'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_input_ref_none", "report.html")
          expect(data.tr_nodata?("Downstream")).to be true
          expect(data.tr_desc("Downstream")).to include table_desc
        end
      end

      context 'with all data filtered out' do
        before(:all) do
          @test = Test.new("tr_input_ref_empty")
          @test.run
        end
        it 'shall display an appropriate note instead of an empty table', doc_refs: ['DoxTrace_HTML_TraceabilityReportInput'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_input_ref_empty", "report.html")
          expect(data.tr_nodata?("Downstream")).to be true
          expect(data.tr_desc("Downstream")).to include table_desc
        end
      end

      context 'with valid data' do
        before(:all) do
          @test = Test.new("tr_input_ref_table")
          @test.run
        end
        it 'shall contain correct data with module/value pairs including TOTAL and links', doc_refs: ['DoxTrace_HTML_TraceabilityReportInput'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_input_ref_table", "report.html")
          expect(data.tr_nodata?("Downstream")).to be false
          expect(data.tr_desc("Downstream")).to include table_desc

          v = data.tr_values("Downstream")

          expect(v["TOTAL"]["all"]).to match_array ["CRS_Req_deref1", "CRS_Req_refderef1", "CRS_Req_refderef2", "CRS_Req_deref2", "CRS_Req_deref3", "CRS_Req_ref1"]
          expect(v["TOTAL"]["Downstream Sufficient"]).to match_array ["CRS_Req_deref1", "CRS_Req_refderef1", "CRS_Req_refderef2", "CRS_Req_deref2", "CRS_Req_deref3"]
          expect(v["TOTAL"]["Downstream Missing"]).to match_array ["CRS_Req_ref1"]
          expect(v["Heading"]["all"]).to match_array ["CRS_Req_deref1", "CRS_Req_refderef1", "CRS_Req_refderef2", "CRS_Req_deref2", "CRS_Req_deref3"]
          expect(v["Heading"]["Downstream Sufficient"]).to match_array ["CRS_Req_deref1", "CRS_Req_refderef1", "CRS_Req_refderef2", "CRS_Req_deref2", "CRS_Req_deref3"]
          expect(v["Heading"]["Downstream Missing"]).to match_array []
          expect(v["Second Document"]["all"]).to match_array ["CRS_Req_ref1"]
          expect(v["Second Document"]["Downstream Sufficient"]).to match_array []
          expect(v["Second Document"]["Downstream Missing"]).to match_array ["CRS_Req_ref1"]
        end
      end
    end

    context 'list of requirements' do
      table_desc = "type = requirement |br| developer = Abc AG |br| status = valid |br| review_status = accepted"
      context 'with no data' do
        before(:all) do
          @test = Test.new("tr_input_list_none")
          @test.run
        end
        it 'shall display an appropriate note instead of an empty table', doc_refs: ['DoxTrace_HTML_TraceabilityReportInput'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_input_ref_none", "report.html")
          expect(data.tr_nodata?("List of Requirements")).to be true
          expect(data.tr_desc("List of Requirements")).to include table_desc
        end
      end

      context 'with all data filtered out' do
        before(:all) do
          @test = Test.new("tr_input_list_empty")
          @test.run
        end
        it 'shall display an appropriate note instead of an empty table', doc_refs: ['DoxTrace_HTML_TraceabilityReportInput'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_input_ref_empty", "report.html")
          expect(data.tr_nodata?("List of Requirements")).to be true
          expect(data.tr_desc("List of Requirements")).to include table_desc
        end
      end

      context 'with valid data' do
        before(:all) do
          @test = Test.new("tr_input_list_table")
          @test.run
        end
        it 'shall contain correct data with module/value pairs including TOTAL and links', doc_refs: ['DoxTrace_HTML_TraceabilityReportInput'] do
          expect(@test.exit_code).to be == 0
          data = HtmlData.new("tr_input_list_table", "report.html")
          expect(data.tr_nodata?("List of Requirements")).to be false
          expect(data.tr_desc("List of Requirements")).to include table_desc

          v = data.tr_list("List of Requirements")
          expect(v.length). to be 6

          table = {"CRS_Req_deref1" =>    {"mod" => "Heading",         "Downstream" => "CRS_Req_ref1, CRS_Req_refderef1, CRS_Req_refderef2"},
                   "CRS_Req_refderef1" => {"mod" => "Heading",         "Downstream" => "CRS_Req_refderef2"},
                   "CRS_Req_refderef2" => {"mod" => "Heading",         "Downstream" => "CRS_Req_notset2"},
                   "CRS_Req_deref2" =>    {"mod" => "Heading",         "Downstream" => "-"},
                   "CRS_Req_deref3" =>    {"mod" => "Heading",         "Downstream" => "CRS_Req_notset2, index.rst, second.rst"},
                   "CRS_Req_ref1" =>      {"mod" => "Second Document", "Downstream" => "[missing]"}}
          v.each do |content|
            t = table[content["ID"]]
            expect(content["mod"]).to eq t["mod"]
            expect(content["Downstream"]).to eq t["Downstream"]
          end
        end
      end
    end

  end
end
