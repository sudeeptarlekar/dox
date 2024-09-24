require_relative 'framework/helper'

module Sphinx
  describe "The attribute security" do
    context 'with correct syntax' do
      before(:all) do
        @test = Test.new("security")
        @test.run
      end

      it 'shall be loaded and displayed correctly without any error', doc_refs: ['DoxTrace_Syntax_Security'] do
        expect(@test.exit_code).to be == 0
        data = HtmlData.new("security", "index.html")

        expect(data.value("InputInformation_SecurityYes", "security")).to eq 'yes'
        expect(data.value("InputRequirement_SecurityYes", "security")).to eq 'yes'
        expect(data.value("SRS_Information_SecurityYes", "security")).to eq 'yes'
        expect(data.value("SRS_Requirement_SecurityYes", "security")).to eq 'yes'
        expect(data.value("SRS_Srs_SecurityYes", "security")).to eq 'yes'
        expect(data.value("SWA_Spec_SecurityYes", "security")).to eq 'yes'
        expect(data.value("SMD_Unit_SecurityYes", "security")).to eq 'yes'
        expect(data.value("SWA_Interface_SecurityYes", "security")).to eq 'yes'
        expect(data.value("SWA_Mod_SecurityYes", "security")).to eq 'yes'

        expect(data.value("InputInformation_SecurityDefault", "security")).to eq 'not_set'
        expect(data.value("InputRequirement_SecurityDefault", "security")).to eq 'not_set'
        expect(data.value("SRS_Information_SecurityDefault", "security")).to eq 'not_set'
        expect(data.value("SRS_Requirement_SecurityDefault", "security")).to eq 'not_set'
        expect(data.value("SRS_Srs_SecurityDefault", "security")).to eq 'not_set'
        expect(data.value("SWA_Spec_SecurityDefault", "security")).to eq 'not_set'
        expect(data.value("SMD_Unit_SecurityDefault", "security")).to eq 'not_set'
        expect(data.value("SWA_Interface_SecurityDefault", "security")).to eq 'not_set'
        expect(data.value("SWA_Mod_SecurityDefault", "security")).to eq 'not_set'

        expect(data.value("SWA_Spec_ReviewStatusRejected", "security")).to eq 'not_set'
      end

      it 'shall derive the value from cal if security is not defined', doc_refs: ['DoxTrace_Syntax_CalToSecurity', 'DoxTrace_HTML_Cal'] do
        data = HtmlData.new("security", "index.html")

        expect(data.value("SWA_Spec_CalNotSet", "security")).to eq 'not_set'
        expect(data.value("SWA_Spec_CalQm", "security")).to eq 'no'
        expect(data.value("SWA_Spec_Cal1", "security")).to eq 'yes'
        expect(data.value("SWA_Spec_Cal2", "security")).to eq 'yes'
        expect(data.value("SWA_Spec_Cal3", "security")).to eq 'yes'
        expect(data.value("SWA_Spec_Cal4", "security")).to eq 'yes'

        expect(data.exist?("SWA_Spec_Cal4", "cal")).to be false
      end

      it 'shall be exported correctly', doc_refs: ['DoxTrace_Syntax_Security', 'DoxTrace_Export_Attributes', 'DoxTrace_Export_Cal'] do
        srs = @test.dim_original_data["spec/test_input/security/export_root/srs/index.dim"]
        expect(srs["SRS_Srs_SecurityYes"]["security"]).to eq 'yes'
        expect(srs["SRS_Srs_SecurityDefault"]["security"]).to eq 'not_set'

        swa = @test.dim_original_data["spec/test_input/security/export_root/swa/index.dim"]
        expect(swa["SWA_Spec_SecurityYes"]["security"]).to eq 'yes'
        expect(swa["SWA_Interface_SecurityYes"]["security"]).to eq 'yes'
        expect(swa["SWA_Mod_SecurityYes"]["security"]).to eq 'yes'
        expect(swa["SWA_Spec_SecurityDefault"]["security"]).to eq 'not_set'
        expect(swa["SWA_Interface_SecurityDefault"]["security"]).to eq 'not_set'
        expect(swa["SWA_Mod_SecurityDefault"]["security"]).to eq 'not_set'
        expect(swa["SWA_Spec_ReviewStatusRejected"]["security"]).to eq 'not_set'

        expect(swa["SWA_Spec_CalNotSet"]["security"]).to eq 'not_set'
        expect(swa["SWA_Spec_CalQm"]["security"]).to eq 'no'
        expect(swa["SWA_Spec_Cal1"]["security"]).to eq 'yes'
        expect(swa["SWA_Spec_Cal1"]["security"]).to eq 'yes'
        expect(swa["SWA_Spec_Cal1"]["security"]).to eq 'yes'
        expect(swa["SWA_Spec_Cal1"]["security"]).to eq 'yes'

        expect(swa["SWA_Spec_CalNotSet"]["security"]).to eq 'not_set'
        expect(swa["SWA_Spec_CalQm"]["security"]).to eq 'no'
        expect(swa["SWA_Spec_Cal1"]["security"]).to eq 'yes'
        expect(swa["SWA_Spec_Cal2"]["security"]).to eq 'yes'
        expect(swa["SWA_Spec_Cal3"]["security"]).to eq 'yes'
        expect(swa["SWA_Spec_Cal4"]["security"]).to eq 'yes'

        expect(swa["SWA_Spec_Cal4"]["cal"]).to eq nil

        smd = @test.dim_original_data["spec/test_input/security/export_root/smd/index.dim"]
        expect(smd["SMD_Unit_SecurityYes"]["security"]).to eq 'yes'
        expect(smd["SMD_Unit_SecurityDefault"]["security"]).to eq 'not_set'
      end
    end

  end
end
