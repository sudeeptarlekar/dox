require_relative 'framework/helper'

module Sphinx
  describe "The attribute miscellaneous" do
    context 'with correct syntax' do
      before(:all) do
        @test = Test.new("miscellaneous")
        @test.run
      end

      it 'shall be loaded and displayed correctly without any error', doc_refs: ['DoxTrace_Syntax_Miscellaneous', 'DoxTrace_HTML_Miscellaneous'] do
        expect(@test.exit_code).to be == 0
        data = HtmlData.new("miscellaneous", "index.html")

        expect(data.exist?("SRS_Information_MiscellaneousSet", "miscellaneous")).to be false
        expect(data.exist?("SRS_Requirement_MiscellaneousSet", "miscellaneous")).to be false
        expect(data.value("InputInformation_MiscellaneousSet", "miscellaneous")).to eq 'Cc'
        expect(data.value("InputRequirement_MiscellaneousSet", "miscellaneous")).to eq 'Dd'

        expect(data.exist?("SRS_Information_MiscellaneousDefault", "miscellaneous")).to be false
        expect(data.exist?("SRS_Requirement_MiscellaneousDefault", "miscellaneous")).to be false
        expect(data.value("InputInformation_MiscellaneousDefault", "miscellaneous")).to eq '-'
        expect(data.value("InputRequirement_MiscellaneousDefault", "miscellaneous")).to eq '-'
      end
    end

    context 'specified in a spec directive' do
      before(:all) do
        @test = Test.new("miscellaneous_spec")
        @test.run
      end

      it 'shall cause dox_trace to abort with exit code != 0 and print an error message', doc_refs: ['DoxTrace_Syntax_Miscellaneous'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'index.rst:7:Error in "spec" directive'
        expect(@test.test_stderr).to include 'unknown option: "miscellaneous"'
      end
    end

    context 'specified in a unit directive' do
      before(:all) do
        @test = Test.new("miscellaneous_unit")
        @test.run
      end

      it 'shall cause dox_trace to abort with exit code != 0 and print an error message', doc_refs: ['DoxTrace_Syntax_Miscellaneous'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'index.rst:7:Error in "unit" directive'
        expect(@test.test_stderr).to include 'unknown option: "miscellaneous"'
      end
    end

    context 'specified in an interface directive' do
      before(:all) do
        @test = Test.new("miscellaneous_interface")
        @test.run
      end

      it 'shall cause dox_trace to abort with exit code != 0 and print an error message', doc_refs: ['DoxTrace_Syntax_Miscellaneous'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'index.rst:7:Error in "interface" directive'
        expect(@test.test_stderr).to include 'unknown option: "miscellaneous"'
      end
    end

    context 'specified in an mod directive' do
      before(:all) do
        @test = Test.new("miscellaneous_mod")
        @test.run
      end

      it 'shall cause dox_trace to abort with exit code != 0 and print an error message', doc_refs: ['DoxTrace_Syntax_Miscellaneous'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'index.rst:7:Error in "mod" directive'
        expect(@test.test_stderr).to include 'unknown option: "miscellaneous"'
      end
    end

    context 'specified in an srs directive' do
      before(:all) do
        @test = Test.new("miscellaneous_srs")
        @test.run
      end

      it 'shall cause dox_trace to abort with exit code != 0 and print an error message', doc_refs: ['DoxTrace_Syntax_Miscellaneous'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'index.rst:7:Error in "srs" directive'
        expect(@test.test_stderr).to include 'unknown option: "miscellaneous"'
      end
    end

  end
end
