require_relative 'framework/helper'

module Sphinx
  describe "The custom attribute directives" do
    context 'with valid configuration' do
      before(:all) do
        @test = Test.new("custom_directives")
        @test.run
      end

      it 'shall assign the attribute to a list of directives', doc_refs: ['DoxTrace_CustomDirectives_Syntax'] do
        expect(@test.exit_code).to be == 0
        data = HtmlData.new("custom_directives", "index.html")

        expect(data.value("SMD_Custom_R1", "custom1")).to eq "1"
        expect(data.value("SWA_Custom_R2", "custom2")).to eq "2"
        expect(data.value("SWA_Custom_R3", "custom3")).to eq "3"
        expect(data.value("SWA_Custom_R4", "custom4")).to eq "4"
        expect(data.value("SRS_Custom_R5", "custom5")).to eq "5"
        expect(data.value("SRS_Custom_R6", "custom6")).to eq "6"
        expect(data.value("SRS_Custom_R7", "custom9")).to eq "9"

        expect(data.value("SMD_Custom_R1", "custom7")).to eq "7"
        expect(data.value("SWA_Custom_R2", "custom7")).to eq "7"
        expect(data.value("SWA_Custom_R3", "custom7")).to eq "7"
        expect(data.value("SWA_Custom_R4", "custom7")).to eq "7"
        expect(data.value("SRS_Custom_R5", "custom7")).to eq "7"
        expect(data.value("SRS_Custom_R6", "custom7")).to eq "7"
        expect(data.value("SRS_Custom_R7", "custom7")).to eq "7"

        expect(data.value("SMD_Custom_R1", "custom8")).to eq "8"
        expect(data.value("SWA_Custom_R2", "custom8")).to eq "8"
        expect(data.exist?("SWA_Custom_R3", "custom8")).to be false
        expect(data.exist?("SWA_Custom_R4", "custom8")).to be false
        expect(data.exist?("SRS_Custom_R5", "custom8")).to be false
        expect(data.exist?("SRS_Custom_R6", "custom8")).to be false
        expect(data.exist?("SRS_Custom_R7", "custom8")).to be false
      end
    end

    context 'config with empty list' do
      before(:all) do
        @test = Test.new("custom_directives_invalid_empty")
        @test.run
      end
      it 'shall cause dox_trace to abort with exit code != 0 and print an error message', doc_refs: ['DoxTrace_CustomDirectives_Check'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'Custom attribute custom in config file must be assigned to a list of at least one directive'
      end
    end

    context 'config missing' do
      before(:all) do
        @test = Test.new("custom_directives_invalid_missing")
        @test.run
      end
      it 'shall cause dox_trace to abort with exit code != 0 and print an error message', doc_refs: ['DoxTrace_CustomDirectives_Check'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'Custom attribute custom in config file must be assigned to a list of at least one directive'
      end
    end

    context 'used for non-specified directives' do
      before(:all) do
        @test = Test.new("custom_directives_invalid_spec")
        @test.run
      end
      it 'shall cause dox_trace to abort with exit code != 0 and print an error message', doc_refs: ['DoxTrace_CustomDirectives_Syntax'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'index.rst:4:Error in "spec" directive'
        expect(@test.test_stderr).to include 'unknown option: "custom"'
      end
    end

    context 'config wrong type' do
      before(:all) do
        @test = Test.new("custom_directives_invalid_type")
        @test.run
      end
      it 'shall cause dox_trace to abort with exit code != 0 and print an error message', doc_refs: ['DoxTrace_CustomDirectives_Check'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'Custom attribute custom in config file must be assigned to a list of at least one directive'
      end
    end

    context 'config with invalid value' do
      before(:all) do
        @test = Test.new("custom_directives_invalid_value")
        @test.run
      end
      it 'shall cause dox_trace to abort with exit code != 0 and print an error message', doc_refs: ['DoxTrace_CustomDirectives_Check'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'Custom attribute custom in config file is assigned to invalid directive file'
      end
    end

  end
end
