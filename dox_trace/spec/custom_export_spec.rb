require_relative 'framework/helper'

module Sphinx
  describe "The custom attribute export" do
    context 'with valid configuration' do
      before(:all) do
        @test = Test.new("custom_export")
        @test.run
      end

      it 'shall export the attribute if set to yes', doc_refs: ['DoxTrace_CustomExport_Syntax'] do
        expect(@test.exit_code).to be == 0
        content = File.read("spec/test_input/custom_export/export_root/swa/index.dim")

        # workaround with regex until Dim officially supports custom attributes

        expect(content).to match /SWA_Custom_R2:.*custom_complex_text: '\*\*bold\*\*\s*\n.*- first\s*\n\s*- second'.*custom_enum: '*a, b, c.*custom_refs: '*SMD_Custom_R0,\s*SWA_Custom_R2,\s*SMD_Custom_R1/m
        expect(content).to match /SWA_Custom_R3:.*custom_refs: custom_attr/m
     end

      it 'shall not export the attribute if set to no', doc_refs: ['DoxTrace_CustomExport_Syntax'] do
        expect(@test.exit_code).to be == 0
        content = File.read("spec/test_input/custom_export/export_root/smd/index.dim")

        # workaround with regex until Dim officially supports custom attributes

        expect(content).to match     /SMD_Custom_R1:.*custom1/m # custom1 export set to yes
        expect(content).not_to match /SMD_Custom_R1:.*custom2/m # custom2 export set to no
        expect(content).not_to match /SMD_Custom_R1:.*custom3/m # custom3 export set to no
      end
    end

    context 'config wrong type' do
      before(:all) do
        @test = Test.new("custom_export_invalid_type")
        @test.run
      end
      it 'shall cause dox_trace to abort with exit code != 0 and print an error message', doc_refs: ['DoxTrace_CustomExport_Syntax'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'Custom attribute custom in config file has invalid type for export'
      end
    end

    context 'config with invalid value' do
      before(:all) do
        @test = Test.new("custom_export_invalid_value")
        @test.run
      end
      it 'shall cause dox_trace to abort with exit code != 0 and print an error message', doc_refs: ['DoxTrace_CustomExport_Syntax'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'Custom attribute custom in config file has invalid value nope for export'
      end
    end

  end
end
