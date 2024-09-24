require_relative 'framework/helper'

module Sphinx
  describe "The attribute sources" do
    context 'with correct syntax' do
      before(:all) do
        @test = Test.new("sources")
        @test.run
      end

      it 'shall be loaded and displayed correctly without any error', doc_refs: ['DoxTrace_Syntax_Sources', 'DoxTrace_HTML_Sources'] do
        expect(@test.exit_code).to be == 0
        data = HtmlData.new("sources", "index.html")
        data_subpage = HtmlData.new("sources", "doc/subpage.html")

        expect(data.value("SRS_Requirement_SourcesSet", "sources")).to eq 'Makefile'
        expect(data.value("InputRequirement_SourcesSet", "sources")).to eq 'Makefile, index.rst'
        expect(data.value("SRS_Srs_SourcesSet", "sources")).to eq 'Makefile'
        expect(data.value("SWA_Spec_SourcesSet", "sources")).to eq 'src/test.abc'
        expect(data.value("SMD_Unit_SourcesSet", "sources")).to eq 'src/test.abc, Makefile'
        expect(data.value("SWA_Interface_SourcesSet", "sources")).to eq 'Makefile, src/test.abc'
        expect(data.value("SMD_Interface_SourcesSet", "sources")).to eq 'Makefile, src/test.abc'

        expect(data_subpage.value("SMD_Unit_ModuleDoc", "sources")).to eq 'doc/subpage.rst'

        expect(data.exist?("SRS_Requirement_SourcesDefault", "sources")).to be false
        expect(data.exist?("InputRequirement_SourcesDefault", "sources")).to be false
        expect(data.exist?("SRS_Srs_SourcesDefault", "sources")).to be false
        expect(data.exist?("SWA_Spec_SourcesDefault", "sources")).to be false
        expect(data.value("SMD_Unit_SourcesDefault", "sources")).to eq '[missing]'
        expect(data.exist?("SWA_Interface_SourcesDefault", "sources")).to be false
        expect(data.value("SMD_Interface_SourcesDefault", "sources")).to eq '[missing]'

        expect(data.exist?("SWA_Spec_TagsCovered", "sources")).to be false
        expect(data.value("SMD_Unit_TagsCovered", "sources")).to eq '-'
        expect(data.value("SMD_Interface_TagsCovered", "sources")).to eq '-'
        expect(data.exist?("SWA_Spec_StatusInvalid", "sources")).to be false
        expect(data.value("SMD_Unit_StatusInvalid", "sources")).to eq '-'
        expect(data.exist?("SWA_Interface_StatusInvalid", "sources")).to be false
        expect(data.value("SMD_Interface_StatusInvalid", "sources")).to eq '-'
      end

      it 'shall be exported correctly', doc_refs: ['DoxTrace_Syntax_Sources', 'DoxTrace_Export_Attributes'] do
        srs = @test.dim_original_data["spec/test_input/sources/export_root/srs/index.dim"]
        expect(srs["SRS_Srs_SourcesSet"]["sources"]).to eq 'Makefile'
        expect(srs["SRS_Srs_SourcesDefault"]["sources"]).to eq ''

        swa = @test.dim_original_data["spec/test_input/sources/export_root/swa/index.dim"]
        expect(swa["SWA_Spec_SourcesSet"]["sources"]).to eq 'src/test.abc'
        expect(swa["SWA_Interface_SourcesSet"]["sources"]).to eq 'Makefile, src/test.abc'
        expect(swa["SWA_Spec_SourcesDefault"]["sources"]).to eq ''
        expect(swa["SWA_Interface_SourcesDefault"]["sources"]).to eq ''
        expect(swa["SWA_Spec_TagsCovered"]["sources"]).to eq ''
        expect(swa["SWA_Spec_StatusInvalid"]["sources"]).to eq ''
        expect(swa["SWA_Interface_StatusInvalid"]["sources"]).to eq ''

        smd = @test.dim_original_data["spec/test_input/sources/export_root/smd/index.dim"]
        expect(smd["SMD_Unit_SourcesSet"]["sources"]).to eq 'src/test.abc, Makefile'
        expect(smd["SMD_Interface_SourcesSet"]["sources"]).to eq 'Makefile, src/test.abc'
        expect(smd["SMD_Unit_SourcesDefault"]["sources"]).to eq ''
        expect(smd["SMD_Interface_SourcesDefault"]["sources"]).to eq ''
        expect(smd["SMD_Unit_TagsCovered"]["sources"]).to eq ''
        expect(smd["SMD_Interface_TagsCovered"]["sources"]).to eq ''
        expect(smd["SMD_Unit_StatusInvalid"]["sources"]).to eq ''
        expect(smd["SMD_Interface_StatusInvalid"]["sources"]).to eq ''
      end
    end

    context 'specified in an information directive' do
      before(:all) do
        @test = Test.new("sources_information")
        @test.run
      end

      it 'shall cause dox_trace to abort with exit code != 0 and print an error message', doc_refs: ['DoxTrace_Syntax_Sources'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'index.rst:7:Error in "information" directive'
        expect(@test.test_stderr).to include 'unknown option: "sources"'
      end
    end

    context 'specified in an mod directive' do
      before(:all) do
        @test = Test.new("sources_mod")
        @test.run
      end

      it 'shall cause dox_trace to abort with exit code != 0 and print an error message', doc_refs: ['DoxTrace_Syntax_Sources'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'index.rst:7:Error in "mod" directive'
        expect(@test.test_stderr).to include 'unknown option: "sources"'
      end
    end

  end
end
