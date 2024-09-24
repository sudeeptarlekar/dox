require_relative 'framework/helper'

module Sphinx
  describe "The custom attribute categories" do
    context 'with valid configuration' do
      before(:all) do
        @test = Test.new("custom_categories")
        @test.run
      end

      it 'shall filter the attribute for the directives correctly without any error', doc_refs: ['DoxTrace_CustomCategories_Syntax', 'DoxTrace_CustomCategories_Value'] do
        expect(@test.exit_code).to be == 0
        data = HtmlData.new("custom_categories", "index.html")

        expect(data.value("Custom_ReqInput", "custom1")).to eq "1"
        expect(data.exist?("Custom_ReqSystem", "custom1")).to be false
        expect(data.value("SRS_Custom_ReqSoftware", "custom1")).to eq "1"
        expect(data.exist?("Custom_InfoInput", "custom1")).to be false
        expect(data.exist?("Custom_InfoSystem", "custom1")).to be false
        expect(data.exist?("SRS_Custom_InfoSoftware", "custom1")).to be false
        expect(data.exist?("SMD_Custom_Unit", "custom1")).to be false

        expect(data.exist?("Custom_ReqInput", "custom2")).to be false
        expect(data.exist?("Custom_ReqSystem", "custom2")).to be false
        expect(data.value("SRS_Custom_ReqSoftware", "custom2")).to eq "2"
        expect(data.exist?("Custom_InfoInput", "custom2")).to be false
        expect(data.exist?("Custom_InfoSystem", "custom2")).to be false
        expect(data.value("SRS_Custom_InfoSoftware", "custom2")).to eq "2"
        expect(data.exist?("SMD_Custom_Unit", "custom2")).to be false

        expect(data.exist?("SRS_Custom_ReqSoftware", "custom3")).to be false
        expect(data.value("SMD_Custom_Unit", "custom3")).to eq "3"

        expect(data.value("Custom_ReqInput", "custom4")).to eq "4"
        expect(data.value("Custom_ReqSystem", "custom4")).to eq "4"
        expect(data.value("SRS_Custom_ReqSoftware", "custom4")).to eq "4"
      end
    end

    context 'config missing in a requirement/information directive' do
      before(:all) do
        @test = Test.new("custom_categories_invalid_missing")
        @test.run
      end
      it 'shall cause dox_trace to abort with exit code != 0 and print an error message', doc_refs: ['DoxTrace_CustomCategories_Syntax'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'Custom attribute custom in config file must be assigned to a list of at least one category'
      end
    end

    context 'config with wrong type' do
      before(:all) do
        @test = Test.new("custom_categories_invalid_type")
        @test.run
      end
      it 'shall cause dox_trace to abort with exit code != 0 and print an error message', doc_refs: ['DoxTrace_CustomCategories_Syntax'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'Custom attribute custom in config file must be assigned to a list of at least one category'
      end
    end

    context 'config with empty list' do
      before(:all) do
        @test = Test.new("custom_categories_invalid_empty")
        @test.run
      end
      it 'shall cause dox_trace to abort with exit code != 0 and print an error message', doc_refs: ['DoxTrace_CustomCategories_Syntax'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'Custom attribute custom in config file must be assigned to a list of at least one category'
      end
    end

    context 'config with invalid value' do
      before(:all) do
        @test = Test.new("custom_categories_invalid_value")
        @test.run
      end
      it 'shall cause dox_trace to abort with exit code != 0 and print an error message', doc_refs: ['DoxTrace_CustomCategories_Value'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'Custom attribute custom in config file is assigned to invalid category hardware'
      end
    end

  end
end
