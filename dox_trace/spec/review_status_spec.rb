require_relative 'framework/helper'

module Sphinx
  describe "The attribute review_status" do
    context 'with correct syntax' do
      before(:all) do
        @test = Test.new("review_status")
        @test.run
      end

      it 'shall be loaded and displayed correctly without any error', doc_refs: ['DoxTrace_Syntax_ReviewStatus'] do
        expect(@test.exit_code).to be == 0
        data = HtmlData.new("review_status", "index.html")

        expect(data.value("InputInformation_ReviewStatusNotReviewed", "review_status")).to eq 'not_reviewed'
        expect(data.value("InputRequirement_ReviewStatusNotReviewed", "review_status")).to eq 'not_reviewed'
        expect(data.value("SRS_Information_ReviewStatusNotReviewed", "review_status")).to eq 'not_reviewed'
        expect(data.value("SRS_Requirement_ReviewStatusNotReviewed", "review_status")).to eq 'not_reviewed'
        expect(data.value("SRS_Srs_ReviewStatusNotReviewed", "review_status")).to eq 'not_reviewed'
        expect(data.value("SWA_Spec_ReviewStatusNotReviewed", "review_status")).to eq 'not_reviewed'
        expect(data.value("SMD_Unit_ReviewStatusRejected", "review_status")).to eq 'rejected'
        expect(data.value("SWA_Interface_ReviewStatusNotReviewed", "review_status")).to eq 'not_reviewed'
        expect(data.value("SWA_Mod_ReviewStatusNotReviewed", "review_status")).to eq 'not_reviewed'

        expect(data.value("InputRequirement_ReviewStatusDefault", "review_status")).to eq 'not_reviewed'

        expect(data.value("InputRequirement_ReviewStatusAccepted", "review_status")).to eq 'accepted'
        expect(data.value("InputRequirement_ReviewStatusRejected", "review_status")).to eq 'rejected'
        expect(data.value("InputRequirement_StatusInvalid", "review_status")).to eq 'not_reviewed'
      end

      it 'shall be exported correctly', doc_refs: ['DoxTrace_Syntax_ReviewStatus', 'DoxTrace_Export_Attributes'] do
        srs = @test.dim_original_data["spec/test_input/review_status/export_root/srs/index.dim"]
        expect(srs["SRS_Srs_ReviewStatusNotReviewed"]["review_status"]).to eq 'not_reviewed'
        expect(srs["SRS_Srs_ReviewStatusDefault"]["review_status"]).to eq 'accepted'

        swa = @test.dim_original_data["spec/test_input/review_status/export_root/swa/index.dim"]
        expect(swa["SWA_Spec_ReviewStatusNotReviewed"]["review_status"]).to eq 'not_reviewed'
        expect(swa["SWA_Interface_ReviewStatusNotReviewed"]["review_status"]).to eq 'not_reviewed'
        expect(swa["SWA_Mod_ReviewStatusNotReviewed"]["review_status"]).to eq 'not_reviewed'
        expect(swa["SWA_Spec_ReviewStatusDefault"]["review_status"]).to eq 'accepted'
        expect(swa["SWA_Interface_ReviewStatusDefault"]["review_status"]).to eq 'accepted'
        expect(swa["SWA_Mod_ReviewStatusDefault"]["review_status"]).to eq 'accepted'

        smd = @test.dim_original_data["spec/test_input/review_status/export_root/smd/index.dim"]
        expect(smd["SMD_Unit_ReviewStatusRejected"]["review_status"]).to eq 'rejected'
        expect(smd["SMD_Unit_ReviewStatusDefault"]["review_status"]).to eq 'accepted'
      end

      it 'shall only be shown in HTML if not accepted or type is input', doc_refs: ['DoxTrace_HTML_ReviewStatus'] do
        data = HtmlData.new("review_status", "index.html")

        expect(data.exist?("InputInformation_ReviewStatusNotReviewed", "review_status")).to be true
        expect(data.exist?("InputRequirement_ReviewStatusNotReviewed", "review_status")).to be true
        expect(data.exist?("SRS_Information_ReviewStatusNotReviewed", "review_status")).to be true
        expect(data.exist?("SRS_Requirement_ReviewStatusNotReviewed", "review_status")).to be true
        expect(data.exist?("SWA_Spec_ReviewStatusNotReviewed", "review_status")).to be true
        expect(data.exist?("SMD_Unit_ReviewStatusRejected", "review_status")).to be true
        expect(data.exist?("SWA_Interface_ReviewStatusNotReviewed", "review_status")).to be true
        expect(data.exist?("SWA_Mod_ReviewStatusNotReviewed", "review_status")).to be true

        expect(data.exist?("InputInformation_ReviewStatusDefault", "review_status")).to be false
        expect(data.exist?("InputRequirement_ReviewStatusDefault", "review_status")).to be true
        expect(data.exist?("SRS_Information_ReviewStatusDefault", "review_status")).to be false
        expect(data.exist?("SRS_Requirement_ReviewStatusDefault", "review_status")).to be false
        expect(data.exist?("SWA_Spec_ReviewStatusDefault", "review_status")).to be false
        expect(data.exist?("SMD_Unit_ReviewStatusDefault", "review_status")).to be false
        expect(data.exist?("SWA_Interface_ReviewStatusDefault", "review_status")).to be false
        expect(data.exist?("SWA_Mod_ReviewStatusDefault", "review_status")).to be false

        expect(data.exist?("InputRequirement_ReviewStatusAccepted", "review_status")).to be true
        expect(data.exist?("InputRequirement_ReviewStatusRejected", "review_status")).to be true
        expect(data.exist?("InputRequirement_StatusInvalid", "review_status")).to be true
        expect(data.exist?("InputInformation_StatusInvalid", "review_status")).to be false
      end
    end
  end
end
