require_relative 'framework/helper'

module Sphinx
  describe "dox_trace" do

    context 'in general' do
      before(:all) do
        @test = Test.new("general")
        @test.run
      end

      it 'shall create anchors for every specification', doc_refs: ['DoxTrace_Syntax_Anchor'] do
        expect(@test.exit_code).to be == 0 # no invalid refs
        data = HtmlData.new("general", "index.html")

        expect(data.html).to match /href="#srs_requirement_anchor"/
        expect(data.html).to match /href="#srs_information_anchor"/
        expect(data.html).to match /href="#srs_srs_anchor"/
        expect(data.html).to match /href="#swa_spec_anchor"/
        expect(data.html).to match /href="#smd_unit_anchor"/
        expect(data.html).to match /href="#swa_interface_anchor"/
      end

      it 'shall strip the attribute values', doc_refs: ['DoxTrace_Syntax_Stripped'] do
        expect(@test.exit_code).to be == 0 # no error due to leading / trailing whitespaces
        data = HtmlData.new("general", "index.html")

        expect(data.value("SWA_Spec_DoubleSingle", "status")).to eq ""
        expect(data.value("SWA_Spec_SingleDouble", "status")).to eq ""
        expect(data.value("SWA_Spec_Stripped", "status")).to eq "valid"
      end

      it 'shall treat empty values as empty strings', doc_refs: ['DoxTrace_Syntax_Empty'] do
        expect(@test.exit_code).to be == 0 # no error due to leading / trailing whitespaces
        data = HtmlData.new("general", "index.html")

        # draft is default
        expect(data.value("SWA_Spec_NotSpecified", "status")).to eq "draft"
        expect(data.value("SWA_Spec_NoValue", "status")).to eq ""
        expect(data.value("SWA_Spec_DoubleSingle", "status")).to eq ""
        expect(data.value("SWA_Spec_SingleDouble", "status")).to eq ""
        expect(data.value("SWA_Spec_Spaces", "status")).to eq ""
      end

      it 'shall load multi-enum attributes correctly', doc_refs: ['DoxTrace_Syntax_Multi'] do
        data = HtmlData.new("general", "index.html")

        expect(data.value("SMD_Unit_MultiStripAndUnique", "tags")).to eq "obd, swa, smd"
        expect(data.value("SMD_Unit_MultiStripAndUnique", "verification_methods")).to eq "on_target, off_target, manual"
        expect(data.value("SMD_Unit_MultiStripAndUnique", "sources")).to eq "conf.py, index.rst, Makefile"
        expect(data.value("SMD_Unit_MultiStripAndUnique", "upstream references")).to eq "#srs_information_anchor, #srs_requirement_anchor"
        expect(data.value("SMD_Unit_MultiStripAndUnique", "downstream references")).to eq "#smd_unit_anchor"

        # stripped to empty, defaults are used
        expect(data.value("SMD_Unit_MultiEmpty", "tags")).to eq "-"
        expect(data.value("SMD_Unit_MultiEmpty", "verification_methods")).to eq "off_target"
        expect(data.value("SMD_Unit_MultiEmpty", "sources")).to eq ""
        expect(data.value("SMD_Unit_MultiEmpty", "upstream references")).to eq "[missing]"
        expect(data.value("SMD_Unit_MultiEmpty", "downstream references")).to eq "-"
      end

      it 'shall load free-text attributes and the content correctly', doc_refs: ['DoxTrace_Syntax_FreeText'] do
        data = HtmlData.new("general", "index.html")

        # take the strings as is - even if they would not be accepted by Dim
        expect(data.value("SMD_Unit_Free", "verification_criteria")).to eq ",,"
        expect(data.value("SMD_Unit_Free", "status")).to eq ",,"
        expect(data.value("SMD_Unit_Free", "developer")).to eq ",,"
        expect(data.value("SMD_Unit_Free", "tester")).to eq ",,"
        expect(data.value("SMD_Unit_Free", "asil")).to eq ",,"
        expect(data.value("SMD_Unit_Free", "cal")).to eq ",,"
        expect(data.value("SMD_Unit_Free", "review_status")).to eq ",,"
        expect(data.value("Requirement_Free", "feature")).to eq ",,"
        expect(data.value("Requirement_Free", "change_request")).to eq ",,"
        expect(data.value("Requirement_Free", "comment")).to eq ",,"
        expect(data.value("Requirement_Free", "miscellaneous")).to eq ",,"
        expect(data.value("Requirement_Free", "content")).to match /#subheading.*highlight.*123/m
      end

      it 'shall preserve newlines in attributes expect line ends with backslash', doc_refs: ['DoxTrace_Syntax_Newlines'] do
        data = HtmlData.new("general", "index.html")

        expect(data.value("SRS_Requirement_NewLine1", "custom_complex_text")).to eq "No newline here"
        expect(data.value("SRS_Requirement_NewLine2", "custom_complex_text")).to eq "No newline here"
        expect(data.value("SRS_Requirement_NewLine3", "custom_complex_text")).to eq "No newline here"
        expect(data.value("SRS_Requirement_NewLine4", "custom_complex_text")).to eq "No newline here"
        expect(data.value("SRS_Requirement_NewLine5", "custom_complex_text")).to eq "No newline here"
        expect(data.value("SRS_Requirement_NewLine6", "custom_complex_text")).to match /Has\S*\n\S*three\S*\n\S*lines/m
        expect(data.value("SRS_Requirement_NewLine7", "custom_complex_text")).to match /Has\S*\n\S*two lines/m
      end
    end
  end
end
