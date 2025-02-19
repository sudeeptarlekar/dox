require_relative 'framework/helper'

module Sphinx
  describe "The calculated attribute Derived Feature" do
    context 'for specifications' do
      before(:all) do
        @test = Test.new("derived_feature")
        @test.run
      end

      it 'shall be displayed correctly without any error', doc_refs: ['DoxTrace_HTML_DerivedFeature'] do
        expect(@test.exit_code).to be == 0
        data = HtmlData.new("derived_feature", "index.html")

        expect(data.value("SRS_Requirement_Shown", "derived_feature")).to eq "-"
        expect(data.value("SWA_Spec_Shown", "derived_feature")).to eq "-"
        expect(data.value("SMD_Unit_Shown", "derived_feature")).to eq "-"
        expect(data.value("SWA_Interface_Shown", "derived_feature")).to eq "-"
        expect(data.value("SRS_Srs_Shown", "derived_feature")).to eq "-"
        expect(data.exist?("InputRequirement_NotShown", "derived_feature")).to be false
        expect(data.exist?("InputInformation_NotShown", "derived_feature")).to be false
        expect(data.exist?("SRS_Information_NotShown", "derived_feature")).to be false
        expect(data.exist?("SWA_Mod_NotShown", "derived_feature")).to be false

        expect(data.value("SRS_Requirement_child", "derived_feature")).to eq ["H", "J", "I", "K", "L"].sort.join(", ")
        expect(data.value("SWA_Spec_ignoreBackRefs", "derived_feature")).to eq "-"
        expect(data.value("SWA_Spec_unique", "derived_feature")).to eq ["A", "B"].sort.join(", ")
        expect(data.value("SWA_Spec_multi", "derived_feature")).to eq "X<br>Y, X"
      end
    end
  end
end
