require_relative 'framework/helper'

module Sphinx
  describe "The attribute developer" do
    context 'with correct syntax' do
      before(:all) do
        @test = Test.new("developer")
        @test.run
      end

      it 'shall be loaded and displayed correctly without any error', doc_refs: ['DoxTrace_Syntax_Developer', 'DoxTrace_HTML_Developer'] do
        expect(@test.exit_code).to be == 0
        data = HtmlData.new("developer", "index.html")

        expect(data.value("SRS_Requirement_DeveloperXY", "developer")).to eq 'XY'
        expect(data.value("InputRequirement_DeveloperXY", "developer")).to eq 'XY'
        expect(data.value("SRS_Srs_DeveloperXY", "developer")).to eq 'XY'
        expect(data.value("SWA_Spec_DeveloperXY", "developer")).to eq 'XY'
        expect(data.value("SMD_Unit_DeveloperXY", "developer")).to eq 'XY'
        expect(data.value("SWA_Interface_DeveloperXY", "developer")).to eq 'XY'
        expect(data.value("SWA_Mod_DeveloperXY", "developer")).to eq 'XY'

        expect(data.value("SRS_Requirement_DeveloperDefault", "developer")).to eq '[missing]'
        expect(data.value("InputRequirement_DeveloperDefault", "developer")).to eq '[missing]'
        expect(data.value("SRS_Srs_DeveloperDefault", "developer")).to eq '[missing]'
        expect(data.value("SWA_Spec_DeveloperDefault", "developer")).to eq '[missing]'
        expect(data.value("SMD_Unit_DeveloperDefault", "developer")).to eq '[missing]'
        expect(data.value("SWA_Interface_DeveloperDefault", "developer")).to eq '[missing]'
        expect(data.value("SWA_Mod_DeveloperDefault", "developer")).to eq '[missing]'

        expect(data.value("SRS_Srs_DeveloperDefaultStruck", "developer")).to eq '-'
        expect(data.value("SRS_Requirement_DeveloperDefaultStruck", "developer")).to eq '-'
        expect(data.value("InputRequirement_DeveloperDefaultStruck", "developer")).to eq '-'
      end

      it 'shall be exported correctly', doc_refs: ['DoxTrace_Syntax_Developer', 'DoxTrace_Export_Attributes'] do
        srs = @test.dim_original_data["spec/test_input/developer/export_root/srs/index.dim"]

        expect(srs["SRS_Srs_DeveloperXY"]["developer"]).to eq 'XY'
        expect(srs["SRS_Srs_DeveloperDefault"]["developer"]).to eq ''
        expect(srs["SRS_Srs_DeveloperDefaultStruck"]["developer"]).to eq ''

        swa = @test.dim_original_data["spec/test_input/developer/export_root/swa/index.dim"]

        expect(swa["SWA_Spec_DeveloperXY"]["developer"]).to eq 'XY'
        expect(swa["SWA_Interface_DeveloperXY"]["developer"]).to eq 'XY'
        expect(swa["SWA_Mod_DeveloperXY"]["developer"]).to eq 'XY'

        expect(swa["SWA_Spec_DeveloperDefault"]["developer"]).to eq ''
        expect(swa["SWA_Interface_DeveloperDefault"]["developer"]).to eq ''
        expect(swa["SWA_Mod_DeveloperDefault"]["developer"]).to eq ''

        smd = @test.dim_original_data["spec/test_input/developer/export_root/smd/index.dim"]

        expect(smd["SMD_Unit_DeveloperXY"]["developer"]).to eq 'XY'
        expect(smd["SMD_Unit_DeveloperDefault"]["developer"]).to eq ''
      end
    end

    context 'specified in an information directive' do
      before(:all) do
        @test = Test.new("developer_information")
        @test.run
      end

      it 'shall cause dox_trace to abort with exit code != 0 and print an error message', doc_refs: ['DoxTrace_Syntax_Developer'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'index.rst:7:Error in "information" directive'
        expect(@test.test_stderr).to include 'unknown option: "developer"'
      end
    end
  end
end
