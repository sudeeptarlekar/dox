require_relative 'framework/helper'

module Sphinx
  describe "The attribute tester" do
    context 'with correct syntax' do
      before(:all) do
        @test = Test.new("tester")
        @test.run
      end

      it 'shall be loaded and displayed correctly without any error', doc_refs: ['DoxTrace_Syntax_Tester', 'DoxTrace_HTML_Tester'] do
        expect(@test.exit_code).to be == 0
        data = HtmlData.new("tester", "index.html")

        expect(data.value("SRS_Requirement_TesterXY", "tester")).to eq 'XY'
        expect(data.value("InputRequirement_TesterXY", "tester")).to eq 'XY'
        expect(data.value("SRS_Srs_TesterXY", "tester")).to eq 'XY'
        expect(data.value("SWA_Spec_TesterXY", "tester")).to eq 'XY'
        expect(data.value("SMD_Unit_TesterXY", "tester")).to eq 'XY'
        expect(data.value("SWA_Interface_TesterXY", "tester")).to eq 'XY'
        expect(data.exist?("SMD_Interface_TesterXY", "tester")).to be false

        expect(data.value("SRS_Requirement_TesterDefault", "tester")).to eq '[missing]'
        expect(data.value("InputRequirement_TesterDefault", "tester")).to eq '[missing]'
        expect(data.value("SRS_Srs_TesterDefault", "tester")).to eq '[missing]'
        expect(data.value("SWA_Spec_TesterDefault", "tester")).to eq '[missing]'
        expect(data.value("SMD_Unit_TesterDefault", "tester")).to eq '[missing]'
        expect(data.value("SWA_Interface_TesterDefault", "tester")).to eq '[missing]'
        expect(data.exist?("SMD_Interface_TesterDefault", "tester")).to be false

        expect(data.value("SRS_Requirement_TesterDefaultStruck", "tester")).to eq '-'
        expect(data.value("SRS_Srs_TesterDefaultStruck", "tester")).to eq '-'
        expect(data.value("InputRequirement_TesterDefaultStruck", "tester")).to eq '-'
        expect(data.value("InputRequirement_TesterDefaultStruck", "tester")).to eq '-'
        expect(data.value("SRS_Requirement_TesterDefaultTestSetupsNone", "tester")).to eq '-'
        expect(data.value("SRS_Srs_TesterDefaultTestSetupsNone", "tester")).to eq '-'
        expect(data.value("InputRequirement_TesterDefaultTestSetupsNone", "tester")).to eq '-'
      end

      it 'shall be exported correctly', doc_refs: ['DoxTrace_Syntax_Tester', 'DoxTrace_Export_Attributes', 'DoxTrace_Export_Tester'] do
        srs = @test.dim_original_data["spec/test_input/tester/export_root/srs/index.dim"]
        expect(srs["SRS_Srs_TesterXY"]["tester"]).to eq 'XY'
        expect(srs["SRS_Srs_TesterDefault"]["tester"]).to eq ''
        expect(srs["SRS_Srs_TesterDefaultStruck"]["tester"]).to eq ''
        expect(srs["SRS_Srs_TesterDefaultTestSetupsNone"]["tester"]).to eq ''

        swa = @test.dim_original_data["spec/test_input/tester/export_root/swa/index.dim"]
        expect(swa["SWA_Spec_TesterXY"]["tester"]).to eq 'XY'
        expect(swa["SWA_Interface_TesterXY"]["tester"]).to eq 'XY'
        expect(swa["SWA_Spec_TesterDefault"]["tester"]).to eq ''
        expect(swa["SWA_Interface_TesterDefault"]["tester"]).to eq ''

        smd = @test.dim_original_data["spec/test_input/tester/export_root/smd/index.dim"]
        expect(smd["SMD_Unit_TesterXY"]["tester"]).to eq 'XY'
        expect(smd["SMD_Interface_TesterXY"]["tester"]).to eq ''
        expect(smd["SMD_Unit_TesterDefault"]["tester"]).to eq ''
        expect(smd["SMD_Interface_TesterDefault"]["tester"]).to eq ''
      end
    end

    context 'specified in an information directive' do
      before(:all) do
        @test = Test.new("tester_information")
        @test.run
      end

      it 'shall cause dox_trace to abort with exit code != 0 and print an error message', doc_refs: ['DoxTrace_Syntax_Tester'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'index.rst:7:Error in "information" directive'
        expect(@test.test_stderr).to include 'unknown option: "tester"'
      end
    end

    context 'specified in an mod directive' do
      before(:all) do
        @test = Test.new("tester_mod")
        @test.run
      end

      it 'shall cause dox_trace to abort with exit code != 0 and print an error message', doc_refs: ['DoxTrace_Syntax_Tester'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'index.rst:7:Error in "mod" directive'
        expect(@test.test_stderr).to include 'unknown option: "tester"'
      end
    end

  end
end
