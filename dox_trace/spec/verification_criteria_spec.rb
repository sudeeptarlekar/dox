require_relative 'framework/helper'

module Sphinx
  describe "The attribute verification_criteria" do
    context 'with correct syntax' do
      before(:all) do
        @test = Test.new("verification_criteria")
        @test.run
      end

      it 'shall be loaded and displayed correctly without any error', doc_refs: ['DoxTrace_Syntax_VerificationCriteria', 'DoxTrace_HTML_VerificationCriteria'] do
        expect(@test.exit_code).to be == 0
        data = HtmlData.new("verification_criteria", "index.html")

        expect(data.value("SRS_Requirement_VcSet", "verification_criteria")).to eq 'Aa: #available!'
        expect(data.value("InputRequirement_VcSet", "verification_criteria")).to eq 'Bb'
        expect(data.value("SRS_Srs_VcSet", "verification_criteria")).to eq 'Aa: #available!'
        expect(data.value("SWA_Spec_VcSet", "verification_criteria")).to eq 'Cc'
        expect(data.value("SMD_Unit_VcSet", "verification_criteria")).to eq 'Hello<br>world!'
        expect(data.value("SWA_Interface_VcSet", "verification_criteria")).to eq 'Dd'
        expect(data.exist?("SMD_Interface_VcSet", "verification_criteria")).to be false

        expect(data.value("SRS_Requirement_VcDefault", "verification_criteria")).to eq '[missing]'
        expect(data.value("InputRequirement_VcDefault", "verification_criteria")).to eq '-'
        expect(data.value("SRS_Srs_VcDefault", "verification_criteria")).to eq '[missing]'
        expect(data.value("SWA_Spec_VcDefault", "verification_criteria")).to eq '-'
        expect(data.value("SMD_Unit_VcDefault", "verification_criteria")).to eq '-'
        expect(data.value("SWA_Interface_VcDefault", "verification_criteria")).to eq '-'
        expect(data.exist?("SMD_Interface_VcDefault", "verification_criteria")).to be false

        expect(data.value("SRS_Requirement_VcDefaultTool", "verification_criteria")).to eq '-'
        expect(data.value("SRS_Requirement_VcDefaultStruck", "verification_criteria")).to eq '-'
        expect(data.value("SRS_Srs_VcDefaultTool", "verification_criteria")).to eq '-'
        expect(data.value("SRS_Srs_VcDefaultStruck", "verification_criteria")).to eq '-'

        expect(data.value("SRS_Srs_VcEmpty", "verification_criteria")).to eq '[missing]'
        expect(data.value("SRS_Requirement_VcEmptyRaw", "verification_criteria")).to eq '[missing]'

      end

      it 'shall be exported correctly', doc_refs: ['DoxTrace_Syntax_VerificationCriteria', 'DoxTrace_Export_VerificationCriteria', 'DoxTrace_Export_Attributes'] do
        srs = @test.dim_original_data["spec/test_input/verification_criteria/export_root/srs/index.dim"]
        expect(srs["SRS_Srs_VcSet"]["verification_criteria"]).to eq 'See Sphinx documentation.'
        expect(srs["SRS_Srs_VcDefault"]["verification_criteria"]).to eq ''
        expect(srs["SRS_Srs_VcDefaultTool"]["verification_criteria"]).to eq ''
        expect(srs["SRS_Srs_VcDefaultStruck"]["verification_criteria"]).to eq ''
        expect(srs["SRS_Srs_VcEmpty"]["verification_criteria"]).to eq ''

        swa = @test.dim_original_data["spec/test_input/verification_criteria/export_root/swa/index.dim"]
        expect(swa["SWA_Spec_VcSet"]["verification_criteria"]).to eq 'See Sphinx documentation.'
        expect(swa["SWA_Interface_VcSet"]["verification_criteria"]).to eq 'See Sphinx documentation.'
        expect(swa["SWA_Spec_VcDefault"]["verification_criteria"]).to eq ''
        expect(swa["SWA_Interface_VcDefault"]["verification_criteria"]).to eq ''

        smd = @test.dim_original_data["spec/test_input/verification_criteria/export_root/smd/index.dim"]
        expect(smd["SMD_Unit_VcSet"]["verification_criteria"]).to eq 'See Sphinx documentation.'
        expect(smd["SMD_Interface_VcSet"]["verification_criteria"]).to eq nil
        expect(smd["SMD_Unit_VcDefault"]["verification_criteria"]).to eq ''
        expect(smd["SMD_Interface_VcDefault"]["verification_criteria"]).to eq nil
      end
    end

    context 'specified in an information directive' do
      before(:all) do
        @test = Test.new("verification_criteria_information")
        @test.run
      end

      it 'shall cause dox_trace to abort with exit code != 0 and print an error message', doc_refs: ['DoxTrace_Syntax_VerificationCriteria'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'index.rst:7:Error in "information" directive'
        expect(@test.test_stderr).to include 'unknown option: "verification_criteria"'
      end
    end

    context 'specified in an mod directive' do
      before(:all) do
        @test = Test.new("verification_criteria_mod")
        @test.run
      end

      it 'shall cause dox_trace to abort with exit code != 0 and print an error message', doc_refs: ['DoxTrace_Syntax_VerificationCriteria'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'index.rst:7:Error in "mod" directive'
        expect(@test.test_stderr).to include 'unknown option: "verification_criteria"'
      end
    end

  end
end
