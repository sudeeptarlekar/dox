require_relative 'framework/helper'

module Sphinx
  describe "The calculated attribute Upstream References" do
    context 'for specifications' do
      before(:all) do
        @test = Test.new("upstream_references")
        @test.run
      end

      it 'shall be displayed correctly without any error', doc_refs: ['DoxTrace_HTML_UpstreamRefs'] do
        expect(@test.exit_code).to be == 0
        data = HtmlData.new("upstream_references", "index.html")

        expect(data.value("SRS_Requirement_BackwardRefsShown", "Upstream References")).to eq '#inputrequirement_parent'
        expect(data.value("SRS_Information_BackwardRefsShown", "Upstream References")).to eq '#inputrequirement_parent'
        expect(data.value("InputRequirement_BackwardRefsShown", "Upstream References")).to eq '#inputrequirement_parent'
        expect(data.value("InputInformation_BackwardRefsShown", "Upstream References")).to eq '#inputrequirement_parent'
        expect(data.value("SRS_Srs_BackwardRefsShown", "Upstream References")).to eq '#inputrequirement_parent'
        expect(data.value("SWA_Spec_BackwardRefsShown", "Upstream References")).to eq '#inputrequirement_parent'
        expect(data.value("SMD_Unit_BackwardRefsShown", "Upstream References")).to eq '#inputrequirement_parent'
        expect(data.value("SWA_Interface_BackwardRefsShown", "Upstream References")).to eq '#inputrequirement_parent'

        expect(data.value("SMD_Unit_All", "Upstream References")).to eq [
            "#srs_requirement_ref", "#srs_information_ref", "#inputrequirement_ref", "#inputinformation_ref",
            "#srs_srs_ref", "#swa_spec_ref", "#smd_unit_ref", "#swa_interface_ref"].sort.join(", ")

        expect(data.value("SWA_Spec_Unique", "Upstream References")).to eq ["#swa_interface_uniqueparent", "#swa_spec_uniqueparent"].sort.join(", ")

        expect(data.value("SWA_Spec_RoundTrip", "Upstream References")).to eq '[missing]'
        expect(data.value("SMD_Spec_RoundTrip", "Upstream References")).to eq '#swa_spec_roundtrip'

        expect(data.value("SRS_Requirement_RefsDefault", "Upstream References")).to eq '[missing]'
        expect(data.value("SRS_Information_RefsDefault", "Upstream References")).to eq '-'
        expect(data.value("InputRequirement_RefsDefault", "Upstream References")).to eq '-'
        expect(data.value("InputInformation_RefsDefault", "Upstream References")).to eq '-'
        expect(data.value("SRS_Srs_RefsDefault", "Upstream References")).to eq '[missing]'
        expect(data.value("SWA_Mod_RefsDefault", "Upstream References")).to eq '[missing]'
        expect(data.value("SWA_Spec_RefsDefault", "Upstream References")).to eq '[missing]'
        expect(data.value("SMD_Unit_RefsDefault", "Upstream References")).to eq '[missing]'
        expect(data.value("SWA_Interface_RefsDefault", "Upstream References")).to eq '[missing]'
        expect(data.value("SMD_Interface_RefsDefault", "Upstream References")).to eq '[missing]'

        expect(data.value("SRS_Srs_Tool", "Upstream References")).to eq '-'
        expect(data.value("SRS_srs_Invalid", "Upstream References")).to eq '-'
      end
    end
  end
end
