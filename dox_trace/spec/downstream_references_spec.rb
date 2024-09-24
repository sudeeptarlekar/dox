require_relative 'framework/helper'

module Sphinx
  describe "The calculated attribute Downstream References" do
    context 'with correct syntax' do
      before(:all) do
        @test = Test.new("refs")
        @test.run
      end

      it 'shall be loaded and displayed correctly without any error', doc_refs: ['DoxTrace_Syntax_Refs', 'DoxTrace_HTML_DownstreamRefs'] do
        expect(@test.exit_code).to be == 0
        data = HtmlData.new("refs", "index.html")

        expect(data.value("SRS_Requirement_RefsSet", "Downstream References")).to eq '#smd_unit_refsset, #srs_requirement_refsdefault'
        expect(data.value("SRS_Information_RefsSet", "Downstream References")).to eq '#srs_information_refsdefault'
        expect(data.value("InputRequirement_RefsSet", "Downstream References")).to eq '#inputrequirement_refsdefault'
        expect(data.value("InputInformation_RefsSet", "Downstream References")).to eq '#inputinformation_refsdefault'
        expect(data.value("SRS_Srs_RefsSet", "Downstream References")).to eq '#smd_unit_refsset, #srs_srs_refsdefault'
        expect(data.value("SWA_Spec_RefsSet", "Downstream References")).to eq '#swa_spec_refsdefault'
        expect(data.value("SMD_Unit_RefsSet", "Downstream References")).to eq '#smd_unit_refsdefault'
        expect(data.value("SWA_Interface_RefsSet", "Downstream References")).to eq '#smd_unit_refsset, #swa_interface_refsdefault'
        expect(data.value("SMD_Interface_RefsSet", "Downstream References")).to eq '#smd_unit_refsset'

        expect(data.value("SRS_Requirement_RefsDefault", "Downstream References")).to eq '[missing]'
        expect(data.value("SRS_Information_RefsDefault", "Downstream References")).to eq '-'
        expect(data.value("InputRequirement_RefsDefault", "Downstream References")).to eq '[missing]'
        expect(data.value("InputInformation_RefsDefault", "Downstream References")).to eq '-'
        expect(data.value("SRS_Srs_RefsDefault", "Downstream References")).to eq '[missing]'
        expect(data.value("SWA_Spec_RefsDefault", "Downstream References")).to eq '[missing]'
        expect(data.value("SMD_Unit_RefsDefault", "Downstream References")).to eq '-'
        expect(data.value("SWA_Interface_RefsDefault", "Downstream References")).to eq '[missing]'
        expect(data.value("SMD_Interface_RefsDefault", "Downstream References")).to eq '-'

        expect(data.value("SWA_Spec_TagsCovered", "Downstream References")).to eq '-'
        expect(data.value("SWA_Spec_StatusInvalid", "Downstream References")).to eq '-'

        expect(data.value("SWA_Spec_RoundTrip", "Downstream References")).to eq '#smd_spec_roundtrip'
        expect(data.value("SMD_Spec_RoundTrip", "Downstream References")).to eq '[missing]'
      end

      it 'shall be exported correctly', doc_refs: ['DoxTrace_Syntax_Refs', 'DoxTrace_Export_Attributes'] do
        srs = @test.dim_original_data["spec/test_input/refs/export_root/srs/index.dim"]
        expect(srs["SRS_Srs_RefsSet"]["refs"]).to eq 'SRS_Srs_RefsDefault, SMD_Unit_RefsSet'
        expect(srs["SRS_Srs_RefsDefault"]["refs"]).to eq ''

        swa = @test.dim_original_data["spec/test_input/refs/export_root/swa/index.dim"]
        expect(swa["SWA_Spec_RefsSet"]["refs"]).to eq 'SWA_Spec_RefsDefault'
        expect(swa["SWA_Interface_RefsSet"]["refs"]).to eq 'SWA_Interface_RefsDefault, SMD_Unit_RefsSet'
        expect(swa["SWA_Spec_RefsDefault"]["refs"]).to eq ''
        expect(swa["SWA_Interface_RefsDefault"]["refs"]).to eq ''
        expect(swa["SWA_Spec_TagsCovered"]["refs"]).to eq ''
        expect(swa["SWA_Spec_StatusInvalid"]["refs"]).to eq ''
        expect(swa["SWA_Spec_RoundTrip"]["refs"]).to eq 'SMD_Spec_RoundTrip'

        smd = @test.dim_original_data["spec/test_input/refs/export_root/smd/index.dim"]
        expect(smd["SMD_Unit_RefsSet"]["refs"]).to eq 'SMD_Unit_RefsDefault'
        expect(smd["SMD_Interface_RefsSet"]["refs"]).to eq 'SMD_Unit_RefsSet'
        expect(smd["SMD_Unit_RefsDefault"]["refs"]).to eq ''
        expect(smd["SMD_Interface_RefsDefault"]["refs"]).to eq ''
        expect(smd["SMD_Spec_RoundTrip"]["refs"]).to eq 'SWA_Spec_RoundTrip'
      end
    end

  end
end
