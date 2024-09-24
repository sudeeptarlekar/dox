require_relative 'framework/helper'

module Sphinx
  describe "The custom attribute name" do
    context 'with valid configuration' do
      before(:all) do
        @test = Test.new("custom_name")
        @test.run
      end

      it 'shall be available in RST files for directives', doc_refs: ['DoxTrace_CustomName_Available'] do
        expect(@test.exit_code).to be == 0
        data = HtmlData.new("custom_name", "index.html")

        expect(data.value("SWA_Custom_Set", "custom")).to eq "123"
      end
    end

    context 'config with conflicting name' do
      before(:all) do
        @test = Test.new("custom_name_invalid_exists")
        @test.run
      end
      it 'shall cause dox_trace to abort with exit code != 0 and print an error message', doc_refs: ['DoxTrace_CustomName_Conflict'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'Custom attribute review_status in config file already exists'
      end
    end

    context 'config with reserved name text' do
      before(:all) do
        @test = Test.new("custom_name_invalid_text")
        @test.run
      end
      it 'shall cause dox_trace to abort with exit code != 0 and print an error message', doc_refs: ['DoxTrace_CustomName_Conflict'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'Custom attribute text in config file already exists'
      end
    end

    context 'config with invalid type' do
      before(:all) do
        @test = Test.new("custom_name_invalid_type")
        @test.run
      end
      it 'shall cause dox_trace to abort with exit code != 0 and print an error message', doc_refs: ['DoxTrace_CustomGeneral_Config'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'Names of custom attributes in config file must be strings'
      end
    end

    context 'config invalid dictionary' do
      before(:all) do
        @test = Test.new("custom_name_invalid_value")
        @test.run
      end
      it 'shall cause dox_trace to abort with exit code != 0 and print an error message', doc_refs: ['DoxTrace_CustomGeneral_Config'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'Custom attribute custom in config file has wrong type'
      end
    end

  end
end
