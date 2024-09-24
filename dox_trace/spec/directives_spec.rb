require_relative 'framework/helper'

module Sphinx
  describe "dox_trace" do

    context 'shall provide' do
      before(:all) do
        @test = Test.new("directives_valid")
        @test.run
      end
      it 'the directives requirement, information, srs, spec, unit and interface', doc_refs: ['DoxTrace_Syntax_Types'] do
        expect(@test.exit_code).to be == 0
        data = HtmlData.new("directives_valid", "index.html")

        expect(data.exist?("SRS_Requirement_Type", "status")).to be true
        expect(data.exist?("SRS_Information_Type", "status")).to be true
        expect(data.exist?("SRS_Srs_Type", "status")).to be true
        expect(data.exist?("SWA_Spec_Type", "status")).to be true
        expect(data.exist?("SMD_Unit_Type", "status")).to be true
        expect(data.exist?("SMD_Unit_Type", "status")).to be true
        expect(data.exist?("SWA_Mod_Type", "status")).to be true
      end

      it 'optional attributes and content for the directives', doc_refs: ['DoxTrace_Syntax_Structure'] do
        data = HtmlData.new("directives_valid", "index.html")

        expect(data.value("SWA_Spec_Type", "status")).to eq "draft"
        expect(data.value("SWA_Spec_Attribute", "status")).to eq "valid"
      end

      it 'a mandatory ID argument for the directives', doc_refs: ['DoxTrace_Syntax_Structure'] do
        data = HtmlData.new("directives_valid", "index.html")

        expect(data.value("SWA_Spec_Type", "content")).to eq "[missing]"
        expect(data.value("SWA_Spec_Content", "content")).to include "Some content."
      end
    end

    context 'shall abort the build with an appropriate error message' do
      before(:all) do
        @test = Test.new("directives_no_id")
        @test.run
      end
      it 'if the ID argument for a directive is missing', doc_refs: ['DoxTrace_Syntax_Structure'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include '1 argument(s) required, 0 supplied.'
      end
    end

    context 'shall abort the build with appropriate error message' do
      before(:all) do
        @test = Test.new("directives_no_empty_line")
        @test.run
      end
      it 'if an empty line is missing before the content', doc_refs: ['DoxTrace_Syntax_Structure'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'invalid option block'
      end
    end
  end
end
