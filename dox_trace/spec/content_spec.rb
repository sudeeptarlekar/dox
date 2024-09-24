require_relative 'framework/helper'

module Sphinx
  describe "The content" do
    context 'of specifications' do
      before(:all) do
        @test = Test.new("content")
        @test.run
      end

      it 'shall be loaded and displayed correctly without any error', doc_refs: ['DoxTrace_HTML_Content'] do
        expect(@test.exit_code).to be == 0
        data = HtmlData.new("content", "index.html")

        expect(data.value("SRS_Requirement_Missing", "content")).to eq '[missing]'
        expect(data.value("SRS_Information_Missing", "content")).to eq '[missing]'
        expect(data.value("InputRequirement_Missing", "content")).to eq '[missing]'
        expect(data.value("InputInformation_Missing", "content")).to eq '[missing]'
        expect(data.value("SRS_Srs_Missing", "content")).to eq '[missing]'
        expect(data.value("SWA_Spec_Missing", "content")).to eq '[missing]'
        expect(data.value("SMD_Unit_Missing", "content")).to eq '[missing]'
        expect(data.value("SWA_Interface_Missing", "content")).to eq '[missing]'
        expect(data.value("SWA_Mod_Missing", "content")).to eq '[missing]'

        expect(data.value("SWA_Spec_Struck", "content")).to eq '[missing]'

        expect(data.value("SWA_Spec_Content1", "content")).to eq '<p>Some text.</p>'
        expect(data.value("SWA_Spec_Content2", "content")).to match /counter.*End of example/m
        expect(data.value("SRS_Requirement_Content3", "content")).to match /This is <b>bold<\/b>\./
      end

      it 'shall be exported correctly', doc_refs: ['DoxTrace_Export_Content'] do
        data = @test.dim_original_data["spec/test_input/content/export_root/swa/index.dim"]

        expect(data["SWA_Spec_Missing"]["text"]).to eq ''
        expect(data["SWA_Spec_Content1"]["text"]).to eq 'See Sphinx documentation.'
        expect(data["SWA_Spec_Content2"]["text"]).to eq 'See Sphinx documentation.'
      end
    end
  end
end
