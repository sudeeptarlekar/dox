require_relative 'framework/helper'

module Sphinx
  describe "The attribute asil" do
    context 'with correct syntax' do
      before(:all) do
        @test = Test.new("asil")
        @test.run
      end

      it 'shall be loaded and displayed correctly without any error', doc_refs: ['DoxTrace_Syntax_Asil'] do
        expect(@test.exit_code).to be == 0
        data = HtmlData.new("asil", "index.html")

        expect(data.value("InputInformation_AsilB", "asil")).to eq 'ASIL_B'
        expect(data.value("InputRequirement_AsilB", "asil")).to eq 'ASIL_B'
        expect(data.value("SRS_Information_AsilB", "asil")).to eq 'ASIL_B'
        expect(data.value("SRS_Requirement_AsilB", "asil")).to eq 'ASIL_B'
        expect(data.value("SRS_Srs_AsilB", "asil")).to eq 'ASIL_B'
        expect(data.value("SWA_Spec_AsilB", "asil")).to eq 'ASIL_B'
        expect(data.value("SMD_Unit_AsilB", "asil")).to eq 'ASIL_B'
        expect(data.value("SWA_Interface_AsilB", "asil")).to eq 'ASIL_B'
        expect(data.value("SWA_Mod_AsilB", "asil")).to eq 'ASIL_B'

        expect(data.value("InputInformation_AsilDefault", "asil")).to eq 'not_set'
        expect(data.value("InputRequirement_AsilDefault", "asil")).to eq 'not_set'
        expect(data.value("SRS_Information_AsilDefault", "asil")).to eq 'not_set'
        expect(data.value("SRS_Requirement_AsilDefault", "asil")).to eq 'not_set'
        expect(data.value("SRS_Srs_AsilDefault", "asil")).to eq 'not_set'
        expect(data.value("SWA_Spec_AsilDefault", "asil")).to eq 'not_set'
        expect(data.value("SMD_Unit_AsilDefault", "asil")).to eq 'not_set'
        expect(data.value("SWA_Interface_AsilDefault", "asil")).to eq 'not_set'
        expect(data.value("SWA_Mod_AsilDefault", "asil")).to eq 'not_set'

        expect(data.value("SWA_Spec_ReviewStatusRejected", "asil")).to eq 'not_set'
      end

      it 'shall be exported correctly', doc_refs: ['DoxTrace_Syntax_Asil', 'DoxTrace_Export_Attributes'] do
        srs = @test.dim_original_data["spec/test_input/asil/export_root/srs/index.dim"]

        expect(srs["SRS_Srs_AsilB"]["asil"]).to eq 'ASIL_B'
        expect(srs["SRS_Srs_AsilDefault"]["asil"]).to eq 'not_set'

        swa = @test.dim_original_data["spec/test_input/asil/export_root/swa/index.dim"]

        expect(swa["SWA_Spec_AsilB"]["asil"]).to eq 'ASIL_B'
        expect(swa["SWA_Interface_AsilB"]["asil"]).to eq 'ASIL_B'
        expect(swa["SWA_Mod_AsilB"]["asil"]).to eq 'ASIL_B'

        expect(swa["SWA_Spec_AsilDefault"]["asil"]).to eq 'not_set'
        expect(swa["SWA_Interface_AsilDefault"]["asil"]).to eq 'not_set'
        expect(swa["SWA_Mod_AsilDefault"]["asil"]).to eq 'not_set'

        expect(swa["SWA_Spec_ReviewStatusRejected"]["asil"]).to eq 'not_set'

        smd = @test.dim_original_data["spec/test_input/asil/export_root/smd/index.dim"]

        expect(smd["SMD_Unit_AsilDefault"]["asil"]).to eq 'not_set'
        expect(smd["SMD_Unit_AsilB"]["asil"]).to eq 'ASIL_B'
      end
    end

  end
end
