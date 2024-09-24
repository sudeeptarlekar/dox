require_relative 'framework/helper'

module Sphinx
  describe "The calculated attribute Upstream Tags" do
    context 'for specifications' do
      before(:all) do
        @test = Test.new("upstream_asil")
        @test.run
      end

      it 'shall be displayed correctly without any error', doc_refs: ['DoxTrace_HTML_UpstreamAsil'] do
        expect(@test.exit_code).to be == 0
        data = HtmlData.new("upstream_asil", "index.html")

        expect(data.value("SRS_Requirement_A", "upstream_asil")).to eq "-"
        expect(data.value("SRS_Srs_A", "upstream_asil")).to eq "-"
        expect(data.value("SRS_Information_B", "upstream_asil")).to eq "-"
        expect(data.value("SWA_Spec_C", "upstream_asil")).to eq "-"
        expect(data.value("SMD_Unit_D", "upstream_asil")).to eq "-"
        expect(data.value("SWA_Interface_AA", "upstream_asil")).to eq "-"
        expect(data.value("SWA_Mod_A", "upstream_asil")).to eq "-"
        expect(data.exist?("InputRequirement_AB", "upstream_asil")).to be false
        expect(data.exist?("InputInformation_AC", "upstream_asil")).to be false

        expect(data.value("SWA_Spec_AD", "upstream_asil")).to eq "-"
        expect(data.value("SWA_Spec_BB", "upstream_asil")).to eq "-"
        expect(data.value("SWA_Spec_BC", "upstream_asil")).to eq "ASIL_A(D)"
        expect(data.value("SWA_Spec_BD", "upstream_asil")).to eq "ASIL_B(B)"
        expect(data.value("SWA_Spec_child", "upstream_asil")).to eq ["ASIL_B(C)", "ASIL_B(D)"].sort.join(", ")

        expect(data.value("SMD_Spec_ignoreBackRefs", "upstream_asil")).to eq ["ASIL_A", "ASIL_C", "ASIL_D", "ASIL_A(A)", "ASIL_A(B)"].sort.join(", ")

        expect(data.value("SWA_Spec_unique", "upstream_asil")).to eq ["ASIL_A", "ASIL_C"].sort.join(", ")
      end
    end
  end
end
