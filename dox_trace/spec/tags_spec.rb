require_relative 'framework/helper'

module Sphinx
  describe "The attribute tags" do
    context 'with correct syntax' do

      before(:all) do
        @test = Test.new("tags")
        @test.run
      end

      it 'shall be loaded and displayed correctly without any error', doc_refs: ['DoxTrace_Syntax_Tags', 'DoxTrace_HTML_Tags'] do
        expect(@test.exit_code).to be == 0
        data = HtmlData.new("tags", "index.html")

        expect(data.value("SRS_Information_TagsSet", "tags")).to eq 'srs'
        expect(data.value("SRS_Requirement_TagsSet", "tags")).to eq 'swa'
        expect(data.value("InputInformation_TagsSet", "tags")).to eq 'memory'
        expect(data.value("InputRequirement_TagsSet", "tags")).to eq 'memory, performance'
        expect(data.value("SRS_Srs_TagsSet", "tags")).to eq 'swa'
        expect(data.value("SWA_Spec_TagsSet", "tags")).to eq 'performance'
        expect(data.value("SMD_Unit_TagsSet", "tags")).to eq 'obd, performance'
        expect(data.value("SWA_Interface_TagsSet", "tags")).to eq 'sys, tool'

        expect(data.value("InputInformation_TagsDefault", "tags")).to eq '-'
        expect(data.value("InputRequirement_TagsDefault", "tags")).to eq '-'
        expect(data.value("SRS_Information_TagsDefault", "tags")).to eq '-'
        expect(data.value("SRS_Requirement_TagsDefault", "tags")).to eq '-'
        expect(data.value("SRS_Srs_TagsDefault", "tags")).to eq '-'
        expect(data.value("SWA_Spec_TagsDefault", "tags")).to eq '-'
        expect(data.value("SMD_Unit_TagsDefault", "tags")).to eq '-'
        expect(data.value("SWA_Interface_TagsDefault", "tags")).to eq '-'

        expect(data.value("SMD_Unit_TagsUnitSet", "tags")).to eq 'obd, unit, performance'
        expect(data.value("SWA_Interface_TagsInterfaceSet", "tags")).to eq 'sys, interface, tool'
      end

      it 'shall be exported correctly', doc_refs: ['DoxTrace_Syntax_Tags', 'DoxTrace_Export_Unit', 'DoxTrace_Export_Interface', 'DoxTrace_Export_Mod', 'DoxTrace_Export_Attributes'] do
        srs = @test.dim_original_data["spec/test_input/tags/export_root/srs/index.dim"]
        expect(srs["SRS_Srs_TagsSet"]["tags"]).to eq 'swa'
        expect(srs["SRS_Srs_TagsDefault"]["tags"]).to eq ''

        swa = @test.dim_original_data["spec/test_input/tags/export_root/swa/index.dim"]
        expect(swa["SWA_Spec_TagsSet"]["tags"]).to eq 'performance'
        expect(swa["SWA_Interface_TagsSet"]["tags"]).to eq 'sys, tool, interface'
        expect(swa["SWA_Mod_Empty"]["tags"]).to eq ''
        expect(swa["SWA_Mod_NotExist"]["tags"]).to eq ''
        expect(swa["SWA_Mod_Exist"]["tags"]).to eq 'covered'
        expect(swa["SWA_Spec_TagsDefault"]["tags"]).to eq ''
        expect(swa["SWA_Interface_TagsDefault"]["tags"]).to eq 'interface'
        expect(swa["SWA_Interface_TagsInterfaceSet"]["tags"]).to eq 'sys, interface, tool'

        smd = @test.dim_original_data["spec/test_input/tags/export_root/smd/index.dim"]
        expect(smd["SMD_Unit_TagsUnitSet"]["tags"]).to eq 'obd, unit, performance'
        expect(smd["SMD_Unit_TagsSet"]["tags"]).to eq 'obd, performance, unit'
        expect(smd["SMD_Unit_TagsDefault"]["tags"]).to eq 'unit'
      end
    end

    context 'specified in a mod directive' do
      before(:all) do
        @test = Test.new("tags_mod")
        @test.run
      end

      it 'shall cause dox_trace to abort with exit code != 0 and print an error message', doc_refs: ['DoxTrace_Syntax_Tags'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'index.rst:7:Error in "mod" directive'
        expect(@test.test_stderr).to include 'unknown option: "tags"'
      end
    end

  end
end
