require_relative 'framework/helper'

module Sphinx
  describe "The calculated attribute Upstream Security" do
    context 'for specifications' do
      before(:all) do
        @test = Test.new("upstream_security")
        @test.run
      end

      it 'shall be displayed correctly without any error', doc_refs: ['DoxTrace_HTML_UpstreamSecurity'] do
        expect(@test.exit_code).to be == 0
        data = HtmlData.new("upstream_security", "index.html")

        expect(data.value("SRS_Requirement_yes", "upstream_security")).to eq "-"
        expect(data.value("SRS_Information_no", "upstream_security")).to eq "-"
        expect(data.value("SRS_Srs_yes", "upstream_security")).to eq "-"
        expect(data.value("SWA_Spec_notSet", "upstream_security")).to eq "-"
        expect(data.value("SMD_Unit_yes", "upstream_security")).to eq "-"
        expect(data.value("SWA_Interface_no", "upstream_security")).to eq "-"
        expect(data.value("SWA_Mod_yes", "upstream_security")).to eq "-"
        expect(data.exist?("InputRequirement_notSet", "upstream_security")).to be false
        expect(data.exist?("InputInformation_yes", "upstream_security")).to be false

        expect(data.value("SWA_Spec_yesP1", "upstream_security")).to eq "-"
        expect(data.value("SWA_Spec_yesP2", "upstream_security")).to eq "-"
        expect(data.value("SWA_Spec_noP", "upstream_security")).to eq "yes"
        expect(data.value("SWA_Spec_notSetP", "upstream_security")).to eq "yes"
        expect(data.value("SWA_Spec_child", "upstream_security")).to eq ["no", "not_set"].sort.join(", ")

        expect(data.value("SMD_Spec_ignoreBackRefs1", "upstream_security")).to eq ["yes", "not_set"].sort.join(", ")
        expect(data.value("SMD_Spec_ignoreBackRefs2", "upstream_security")).to eq ["yes", "no", "not_set"].sort.join(", ")
        expect(data.value("SMD_Spec_ignoreBackRefs3", "upstream_security")).to eq "-"

        expect(data.value("SWA_Spec_unique", "upstream_security")).to eq ["yes", "not_set"].sort.join(", ")

        expect(data.value("SWA_Spec_Cal", "upstream_security")).to eq ["yes", "no"].sort.join(", ")
        expect(data.exist?("SWA_Spec_Cal", "upstream_cal")).to be false
      end
    end
  end
end
