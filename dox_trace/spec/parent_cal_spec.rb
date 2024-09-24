require_relative 'framework/helper'

module Sphinx
  describe "The calculated attribute Upstream Cal" do
    context 'for specifications' do
      before(:all) do
        @test = Test.new("upstream_cal")
        @test.run
      end

      it 'shall be displayed correctly without any error', doc_refs: ['DoxTrace_HTML_UpstreamCal'] do
        expect(@test.exit_code).to be == 0
        data = HtmlData.new("upstream_cal", "index.html")

        expect(data.value("SRS_Requirement_Cal1", "upstream_cal")).to eq "-"
        expect(data.value("SRS_Information_Qm", "upstream_cal")).to eq "-"
        expect(data.value("SRS_Srs_Cal2", "upstream_cal")).to eq "-"
        expect(data.value("SWA_Spec_notSet", "upstream_cal")).to eq "-"
        expect(data.value("SMD_Unit_Cal3", "upstream_cal")).to eq "-"
        expect(data.value("SWA_Interface_Qm", "upstream_cal")).to eq "-"
        expect(data.value("SWA_Mod_Cal2", "upstream_cal")).to eq "-"
        expect(data.exist?("InputRequirement_notSet", "upstream_cal")).to be false
        expect(data.exist?("InputInformation_Cal1", "upstream_cal")).to be false

        expect(data.value("SWA_Spec_Cal1P1", "upstream_cal")).to eq "-"
        expect(data.value("SWA_Spec_Cal1P2", "upstream_cal")).to eq "-"
        expect(data.value("SWA_Spec_QmP", "upstream_cal")).to eq "CAL_1"
        expect(data.value("SWA_Spec_notSetP", "upstream_cal")).to eq "CAL_1"
        expect(data.value("SWA_Spec_child", "upstream_cal")).to eq ["QM", "not_set"].sort.join(", ")

        expect(data.value("SMD_Spec_ignoreBackRefs1", "upstream_cal")).to eq ["CAL_1", "CAL_2", "not_set"].sort.join(", ")
        expect(data.value("SMD_Spec_ignoreBackRefs2", "upstream_cal")).to eq ["CAL_3", "QM", "not_set"].sort.join(", ")
        expect(data.value("SMD_Spec_ignoreBackRefs3", "upstream_cal")).to eq "-"

        expect(data.value("SWA_Spec_unique", "upstream_cal")).to eq ["CAL_1", "CAL_2", "not_set"].sort.join(", ")

        expect(data.value("SWA_Spec_Cal", "upstream_cal")).to eq ["CAL_4", "QM"].sort.join(", ")
        expect(data.exist?("SWA_Spec_Cal", "upstream_security")).to be false
      end
    end
  end
end
