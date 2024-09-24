require_relative 'framework/helper'

module Sphinx
  describe "The attribute test_setups" do
    context 'with correct syntax' do
      before(:all) do
        @test = Test.new("test_setups")
        @test.run
      end

      it 'shall be loaded and displayed correctly without any error', doc_refs: ['DoxTrace_Syntax_TestSetups', 'DoxTrace_HTML_TestSetups'] do
        expect(@test.exit_code).to be == 0
        data = HtmlData.new("test_setups", "index.html")

        expect(data.value("SRS_Requirement_TestSetupsSet", "test_setups")).to eq 'on_target, off_target'
        expect(data.value("InputRequirement_TestSetupsSet", "test_setups")).to eq 'manual'
        expect(data.value("SRS_Srs_TestSetupsSet", "test_setups")).to eq 'on_target, off_target'
        expect(data.value("SWA_Spec_TestSetupsSet", "test_setups")).to eq 'off_target, on_target'
        expect(data.value("SMD_Unit_TestSetupsSet", "test_setups")).to eq 'none'
        expect(data.value("SWA_Interface_TestSetupsSet", "test_setups")).to eq 'off_target'
        expect(data.exist?("SMD_Interface_TestSetupsSet", "test_setups")).to be false

        expect(data.value("SRS_Requirement_TestSetupsDefault", "test_setups")).to eq '-'
        expect(data.value("InputRequirement_TestSetupsDefault", "test_setups")).to eq '-'
        expect(data.value("SRS_Srs_TestSetupsDefault", "test_setups")).to eq 'on_target'
        expect(data.value("SWA_Spec_TestSetupsDefault", "test_setups")).to eq 'on_target'
        expect(data.value("SMD_Spec_TestSetupsDefault", "test_setups")).to eq 'off_target'
        expect(data.value("SMD_Unit_TestSetupsDefault", "test_setups")).to eq 'off_target'
        expect(data.value("SWA_Interface_TestSetupsDefault", "test_setups")).to eq 'on_target'

        expect(data.exist?("SMD_Interface_TestSetupsDefault", "test_setups")).to be false
        expect(data.exist?("SWA_Mod_TestSetupsDefault", "test_setups")).to be false
      end

      it 'shall get the value from verification_methods if test_setups is not defined', doc_refs: ['DoxTrace_Syntax_VerificationMethodsToTestSetups', 'DoxTrace_HTML_TestSetups', 'DoxTrace_HTML_VerificationMethods'] do
        expect(@test.exit_code).to be == 0
        data = HtmlData.new("test_setups", "index.html")

        expect(data.value("SWA_Spec_TestSetupsBackward", "test_setups")).to eq 'off_target, on_target'
        expect(data.exist?("SWA_Spec_TestSetupsBackward", "verification_methods")).to be false
        expect(data.value("SWA_Spec_TestSetupsBackwardBoth", "test_setups")).to eq 'manual'
        expect(data.exist?("SWA_Spec_TestSetupsBackwardBoth", "verification_methods")).to be false
      end

      it 'shall be exported correctly', doc_refs: ['DoxTrace_Syntax_TestSetups', 'DoxTrace_Export_Attributes', 'DoxTrace_Export_VerificationMethods', 'DoxTrace_Export_TestSetups'] do
        srs = @test.dim_original_data["spec/test_input/test_setups/export_root/srs/index.dim"]
        expect(srs["SRS_Srs_TestSetupsSet"]["test_setups"]).to eq 'on_target, off_target'
        expect(srs["SRS_Srs_TestSetupsDefault"]["test_setups"]).to eq 'on_target'

        swa = @test.dim_original_data["spec/test_input/test_setups/export_root/swa/index.dim"]
        expect(swa["SWA_Spec_TestSetupsSet"]["test_setups"]).to eq 'off_target, on_target'
        expect(swa["SWA_Interface_TestSetupsSet"]["test_setups"]).to eq 'off_target'
        expect(swa["SWA_Spec_TestSetupsDefault"]["test_setups"]).to eq 'on_target'
        expect(swa["SWA_Interface_TestSetupsDefault"]["test_setups"]).to eq 'on_target'

        expect(swa["SWA_Spec_TestSetupsBackward"]["test_setups"]).to eq 'off_target, on_target'
        expect(swa["SWA_Spec_TestSetupsBackwardBoth"]["test_setups"]).to eq 'manual'
        content = File.read("spec/test_input/test_setups/export_root/swa/index.dim")
        expect(content).not_to include "verification_methods"

        smd = @test.dim_original_data["spec/test_input/test_setups/export_root/smd/index.dim"]
        expect(smd["SMD_Interface_TestSetupsSet"]["test_setups"]).to eq 'none'
        expect(smd["SMD_Unit_TestSetupsSet"]["test_setups"]).to eq 'none'
        expect(smd["SMD_Spec_TestSetupsDefault"]["test_setups"]).to eq 'off_target'
        expect(smd["SMD_Unit_TestSetupsDefault"]["test_setups"]).to eq 'off_target'
        expect(smd["SMD_Interface_TestSetupsDefault"]["test_setups"]).to eq 'none'
      end
    end

    context 'specified in an mod directive' do
      before(:all) do
        @test = Test.new("test_setups_mod")
        @test.run
      end

      it 'shall cause dox_trace to abort with exit code != 0 and print an error message', doc_refs: ['DoxTrace_Syntax_TestSetups'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'index.rst:7:Error in "mod" directive'
        expect(@test.test_stderr).to include 'unknown option: "test_setups"'
      end
    end

    context 'specified in an information directive' do
      before(:all) do
        @test = Test.new("test_setups_information")
        @test.run
      end

      it 'shall cause dox_trace to abort with exit code != 0 and print an error message', doc_refs: ['DoxTrace_Syntax_TestSetups'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'index.rst:7:Error in "information" directive'
        expect(@test.test_stderr).to include 'unknown option: "test_setups"'
      end
    end

  end
end
