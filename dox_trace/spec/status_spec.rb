require_relative 'framework/helper'

module Sphinx
  describe "The attribute status" do
    context 'with correct syntax' do

      before(:all) do
        @test = Test.new("status")
        @test.run
      end

      it 'shall be loaded and displayed correctly without any error', doc_refs: ['DoxTrace_Syntax_Status'] do
        expect(@test.exit_code).to be == 0
        data = HtmlData.new("status", "index.html")

        expect(data.value("InputInformation_StatusValid", "status")).to eq 'valid'
        expect(data.value("InputRequirement_StatusValid", "status")).to eq 'valid'
        expect(data.value("SRS_Information_StatusValid", "status")).to eq 'valid'
        expect(data.value("SRS_Requirement_StatusValid", "status")).to eq 'valid'
        expect(data.value("SRS_Srs_StatusValid", "status")).to eq 'valid'
        expect(data.value("SWA_Spec_StatusValid", "status")).to eq 'valid'
        expect(data.value("SMD_Unit_StatusValid", "status")).to eq 'valid'
        expect(data.value("SWA_Interface_StatusValid", "status")).to eq 'valid'
        expect(data.value("SWA_Mod_StatusValid", "status")).to eq 'valid'

        expect(data.value("InputInformation_StatusDefault", "status")).to eq 'draft'
        expect(data.value("InputRequirement_StatusDefault", "status")).to eq 'draft'
        expect(data.value("SRS_Information_StatusDefault", "status")).to eq 'draft'
        expect(data.value("SRS_Requirement_StatusDefault", "status")).to eq 'draft'
        expect(data.value("SRS_Srs_StatusDefault", "status")).to eq 'draft'
        expect(data.value("SWA_Spec_StatusDefault", "status")).to eq 'draft'
        expect(data.value("SMD_Unit_StatusDefault", "status")).to eq 'draft'
        expect(data.value("SWA_Interface_StatusDefault", "status")).to eq 'draft'
        expect(data.value("SWA_Mod_StatusDefault", "status")).to eq 'draft'

        expect(data.value("SWA_Spec_ReviewStatusRejected", "status")).to eq 'draft'
      end

      it 'shall be exported correctly', doc_refs: ['DoxTrace_Syntax_Status', 'DoxTrace_Export_Attributes'] do
        srs = @test.dim_original_data["spec/test_input/status/export_root/srs/index.dim"]
        expect(srs["SRS_Srs_StatusValid"]["status"]).to eq 'valid'
        expect(srs["SRS_Srs_StatusDefault"]["status"]).to eq 'draft'

        swa = @test.dim_original_data["spec/test_input/status/export_root/swa/index.dim"]
        expect(swa["SWA_Spec_StatusValid"]["status"]).to eq 'valid'
        expect(swa["SWA_Interface_StatusValid"]["status"]).to eq 'valid'
        expect(swa["SWA_Mod_StatusValid"]["status"]).to eq 'valid'
        expect(swa["SWA_Spec_StatusDefault"]["status"]).to eq 'draft'
        expect(swa["SWA_Interface_StatusDefault"]["status"]).to eq 'draft'
        expect(swa["SWA_Mod_StatusDefault"]["status"]).to eq 'draft'
        expect(swa["SWA_Spec_ReviewStatusRejected"]["status"]).to eq 'draft'

        smd = @test.dim_original_data["spec/test_input/status/export_root/smd/index.dim"]
        expect(smd["SMD_Unit_StatusValid"]["status"]).to eq 'valid'
        expect(smd["SMD_Unit_StatusDefault"]["status"]).to eq 'draft'
      end
    end
  end
end
