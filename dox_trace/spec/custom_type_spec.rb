require_relative 'framework/helper'

module Sphinx
  describe "The custom attribute type" do
    context 'with valid configuration' do
      before(:all) do
        @test = Test.new("custom_type")
        @test.run
      end

      it 'shall be available in RST files for directives', doc_refs: ['DoxTrace_CustomTypes_Syntax', 'DoxTrace_CustomTypes_Text', 'DoxTrace_CustomTypes_Enum', 'DoxTrace_CustomTypes_Refs'] do
        expect(@test.exit_code).to be == 0
        data = HtmlData.new("custom_type", "index.html")

        # empty text, enum, refs rendered as "-"
        expect(data.value("SMD_Custom_R1", "custom_complex_text")).to eq "-"
        expect(data.value("SMD_Custom_R1", "custom2")).to eq "-"
        expect(data.value("SMD_Custom_R1", "custom3")).to eq "-"

        expect(data.value("SWA_Custom_S1", "custom_complex_text")).to eq "1"
        expect(data.value("SWA_Custom_S1", "custom2")).to eq "2"
        expect(data.value("SWA_Custom_S1", "custom3")).to eq "#smd_custom_r1"

        expect(data.value("SWA_Custom_S2", "custom_complex_text")).to match /<p><strong>bold<\/strong><\/p>.*<li><p>bullet1<\/p><\/li>.*not_bold/m
        expect(data.value("SWA_Custom_S2", "custom2")).to eq "2, 3"
        expect(data.value("SWA_Custom_S2", "custom3")).to eq "#smd_custom_r1, #swa_custom_r2, #custom-attr"

        expect(data.value("SWA_Custom_S3", "custom3", true)).to eq "SMD_Custom_R1"
        expect(data.value("SWA_Custom_S4", "custom3", true)).to eq "Custom Attributes"
      end
    end

    context 'config with missing value' do
      before(:all) do
        @test = Test.new("custom_type_invalid_missing")
        @test.run
      end
      it 'shall cause dox_trace to abort with exit code != 0 and print an error message', doc_refs: ['DoxTrace_CustomTypes_Syntax'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'Custom attribute custom in config file must have a valid type'
      end
    end

    context 'config with invalid type' do
      before(:all) do
        @test = Test.new("custom_type_invalid_type")
        @test.run
      end
      it 'shall cause dox_trace to abort with exit code != 0 and print an error message', doc_refs: ['DoxTrace_CustomTypes_Syntax'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'Custom attribute custom in config file must have a valid type'
      end
    end

    context 'config with invalid value' do
      before(:all) do
        @test = Test.new("custom_type_invalid_value")
        @test.run
      end
      it 'shall cause dox_trace to abort with exit code != 0 and print an error message', doc_refs: ['DoxTrace_CustomTypes_Syntax'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'Custom attribute custom in config file has invalid type nope'
      end
    end

  end
end
