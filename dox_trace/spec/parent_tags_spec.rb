require_relative 'framework/helper'

module Sphinx
  describe "The calculated attribute Upstream Tags" do
    context 'for specifications' do
      before(:all) do
        @test = Test.new("upstream_tags")
        @test.run
      end

      it 'shall be displayed correctly without any error', doc_refs: ['DoxTrace_HTML_UpstreamTags'] do
        expect(@test.exit_code).to be == 0
        data = HtmlData.new("upstream_tags", "index.html")

        expect(data.value("SRS_Requirement_sys", "upstream_tags")).to eq "-"
        expect(data.value("SRS_Information_srs", "upstream_tags")).to eq "-"
        expect(data.value("SRS_Srs_sys", "upstream_tags")).to eq "-"
        expect(data.value("SWA_Spec_swa", "upstream_tags")).to eq "-"
        expect(data.value("SMD_Unit_smd", "upstream_tags")).to eq "-"
        expect(data.value("SWA_Interface_process", "upstream_tags")).to eq "-"
        expect(data.exist?("InputRequirement_tested", "upstream_tags")).to be false
        expect(data.exist?("InputInformation_covered", "upstream_tags")).to be false
        expect(data.exist?("SWA_Mod_none", "upstream_tags")).to be false

        expect(data.value("SWA_Spec_smd", "upstream_tags")).to eq "-"
        expect(data.value("SWA_Spec_swa1", "upstream_tags")).to eq "-"
        expect(data.value("SWA_Spec_swa2", "upstream_tags")).to eq ["smd", "obd"].sort.join(", ")
        expect(data.value("SWA_Spec_tool", "upstream_tags")).to eq ["obd, swa"].sort.join(", ")
        expect(data.value("SWA_Spec_child", "upstream_tags")).to eq ["swa", "memory", "tool"].sort.join(", ")

        expect(data.value("SMD_Spec_ignoreBackRefs", "upstream_tags")).to eq ["sys", "swa", "smd", "process", "covered"].sort.join(", ")
      end
    end
  end
end
