require_relative 'framework/helper'

module Sphinx
  describe "The custom attribute default" do
    context 'with valid configuration' do
      before(:all) do
        @test = Test.new("custom_default")
        @test.run
      end

      it 'shall set the default value for attributes correctly without any error', doc_refs: ['DoxTrace_CustomDefault_Syntax', 'DoxTrace_CustomDefault_Default'] do
        expect(@test.exit_code).to be == 0
        data = HtmlData.new("custom_default", "index.html")

        expect(data.value("SWA_Custom_Set", "custom1")).to eq "1"
        expect(data.value("SWA_Custom_Set", "custom2")).to eq "2"
        expect(data.value("SWA_Custom_Set", "custom3")).to eq "3"
        expect(data.value("SWA_Custom_Set", "custom4")).to eq "4"
        expect(data.value("SWA_Custom_Set", "custom5")).to eq "5"
        expect(data.value("SWA_Custom_Set", "custom6")).to eq "6"
        expect(data.value("SWA_Custom_Set", "custom7")).to eq "#swa_custom_r2"
        expect(data.value("SWA_Custom_Set", "custom8")).to eq "#swa_custom_r2"
        expect(data.value("SWA_Custom_Set", "custom9")).to eq "#swa_custom_r2"

        expect(data.value("SWA_Custom_NotSet", "custom1")).to eq "-"
        expect(data.value("SWA_Custom_NotSet", "custom2")).to eq "-"
        expect(data.value("SWA_Custom_NotSet", "custom3")).to eq "d3"
        expect(data.value("SWA_Custom_NotSet", "custom4")).to eq "-"
        expect(data.value("SWA_Custom_NotSet", "custom5")).to eq "-"
        expect(data.value("SWA_Custom_NotSet", "custom6")).to eq "d6, d7"
        expect(data.value("SWA_Custom_NotSet", "custom7")).to eq "-"
        expect(data.value("SWA_Custom_NotSet", "custom8")).to eq "-"
        expect(data.value("SWA_Custom_NotSet", "custom9")).to eq "#smd_custom_r1"

        expect(data.value("SWA_Custom_Empty", "custom1")).to eq "-"
        expect(data.value("SWA_Custom_Empty", "custom2")).to eq "-"
        expect(data.value("SWA_Custom_Empty", "custom3")).to eq "d3"
        expect(data.value("SWA_Custom_Empty", "custom4")).to eq "-"
        expect(data.value("SWA_Custom_Empty", "custom5")).to eq "-"
        expect(data.value("SWA_Custom_Empty", "custom6")).to eq "d6, d7"
        expect(data.value("SWA_Custom_Empty", "custom7")).to eq "-"
        expect(data.value("SWA_Custom_Empty", "custom8")).to eq "-"
        expect(data.value("SWA_Custom_Empty", "custom9")).to eq "#smd_custom_r1"
      end
    end

    context 'config with wrong type for text attributes' do
      before(:all) do
        @test = Test.new("custom_default_invalid_text")
        @test.run
      end
      it 'shall cause dox_trace to abort with exit code != 0 and print an error message', doc_refs: ['DoxTrace_CustomDefault_Type'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'Custom attribute custom in config file must have type string for default'
      end
    end

    context 'config with wrong type for non-text attributes' do
      before(:all) do
        @test = Test.new("custom_default_invalid_nontext")
        @test.run
      end
      it 'shall cause dox_trace to abort with exit code != 0 and print an error message', doc_refs: ['DoxTrace_CustomDefault_Type'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'Custom attribute custom in config file must have type list for default'
      end
    end

  end
end
