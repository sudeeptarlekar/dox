require_relative 'framework/helper'

module Sphinx
  describe "The attribute cal" do
    context 'with correct syntax' do
      before(:all) do
        @test = Test.new("cal")
        @test.run
      end

      it 'shall be loaded and displayed correctly without any error', doc_refs: ['DoxTrace_Syntax_Cal'] do
        expect(@test.exit_code).to be == 0
        data = HtmlData.new("cal", "index.html")

        expect(data.value("InputInformation_Cal3", "cal")).to eq 'CAL_3'
        expect(data.value("InputRequirement_Cal4", "cal")).to eq 'CAL_4'
        expect(data.value("SRS_Information_Cal1", "cal")).to eq 'CAL_1'
        expect(data.value("SRS_Requirement_Cal2", "cal")).to eq 'CAL_2'
        expect(data.value("SRS_Srs_CalQm", "cal")).to eq 'QM'
        expect(data.value("SWA_Spec_CalQm", "cal")).to eq 'QM'
        expect(data.value("SMD_Unit_Cal1", "cal")).to eq 'CAL_1'
        expect(data.value("SWA_Interface_CalQm", "cal")).to eq 'QM'
        expect(data.value("SWA_Mod_CalNotSet", "cal")).to eq 'not_set'

        expect(data.value("InputInformation_CalDefault", "cal")).to eq 'not_set'
        expect(data.value("InputRequirement_CalDefault", "cal")).to eq 'not_set'
        expect(data.value("SRS_Information_CalDefault", "cal")).to eq 'not_set'
        expect(data.value("SRS_Requirement_CalDefault", "cal")).to eq 'not_set'
        expect(data.value("SRS_Srs_CalDefault", "cal")).to eq 'not_set'
        expect(data.value("SWA_Spec_CalDefault", "cal")).to eq 'not_set'
        expect(data.value("SMD_Unit_CalDefault", "cal")).to eq 'not_set'
        expect(data.value("SWA_Interface_CalDefault", "cal")).to eq 'not_set'
        expect(data.value("SWA_Mod_CalDefault", "cal")).to eq 'not_set'

        expect(data.value("SWA_Spec_ReviewStatusRejected", "cal")).to eq 'not_set'
      end

      it 'shall derive the value from security if cal is not defined', doc_refs: ['DoxTrace_Syntax_SecurityToCal', 'DoxTrace_HTML_Security'] do
        data = HtmlData.new("cal", "index.html")

        expect(data.value("SWA_Spec_CalYes", "cal")).to eq 'CAL_4'
        expect(data.value("SWA_Spec_CalNo", "cal")).to eq 'QM'
        expect(data.value("SWA_Spec_CalNotSet", "cal")).to eq 'not_set'
        expect(data.value("SWA_Spec_CalYes1", "cal")).to eq 'CAL_1'

        expect(data.exist?("SWA_Spec_CalYes1", "security")).to be false
      end

      it 'shall be exported correctly', doc_refs: ['DoxTrace_Syntax_Cal', 'DoxTrace_Export_Attributes', 'DoxTrace_Export_Security'] do
        srs = @test.dim_original_data["spec/test_input/cal/export_root/srs/index.dim"]
        expect(srs["SRS_Srs_CalQm"]["cal"]).to eq 'QM'
        expect(srs["SRS_Srs_CalDefault"]["cal"]).to eq 'not_set'

        swa = @test.dim_original_data["spec/test_input/cal/export_root/swa/index.dim"]
        expect(swa["SWA_Spec_CalQm"]["cal"]).to eq 'QM'
        expect(swa["SWA_Interface_CalQm"]["cal"]).to eq 'QM'
        expect(swa["SWA_Mod_CalNotSet"]["cal"]).to eq 'not_set'
        expect(swa["SWA_Spec_CalDefault"]["cal"]).to eq 'not_set'
        expect(swa["SWA_Interface_CalDefault"]["cal"]).to eq 'not_set'
        expect(swa["SWA_Mod_CalDefault"]["cal"]).to eq 'not_set'
        expect(swa["SWA_Spec_ReviewStatusRejected"]["cal"]).to eq 'not_set'

        expect(swa["SWA_Spec_CalYes"]["cal"]).to eq 'CAL_4'
        expect(swa["SWA_Spec_CalNo"]["cal"]).to eq 'QM'
        expect(swa["SWA_Spec_CalNotSet"]["cal"]).to eq 'not_set'
        expect(swa["SWA_Spec_CalYes1"]["cal"]).to eq 'CAL_1'

        # security is not exported
        expect(swa["SWA_Spec_CalYes1"]).not_to include "security"

        smd = @test.dim_original_data["spec/test_input/cal/export_root/smd/index.dim"]
        expect(smd["SMD_Unit_Cal1"]["cal"]).to eq 'CAL_1'
        expect(smd["SMD_Unit_CalDefault"]["cal"]).to eq 'not_set'
      end
    end

  end
end
