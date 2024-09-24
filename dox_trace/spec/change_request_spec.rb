require_relative 'framework/helper'

module Sphinx
  describe "The attribute change_request" do
    context 'with correct syntax' do
      before(:all) do
        @test = Test.new("change_request")
        @test.run
      end

      it 'shall be loaded and displayed correctly without any error', doc_refs: ['DoxTrace_Syntax_ChangeRequest', 'DoxTrace_HTML_ChangeRequest'] do
        expect(@test.exit_code).to be == 0
        data = HtmlData.new("change_request", "index.html")

        expect(data.exist?("SRS_Requirement_ChangeRequestSet", "change_request")).to be false
        expect(data.value("InputRequirement_ChangeRequestSet", "change_request")).to eq 'Dd'

        expect(data.exist?("SRS_Requirement_ChangeRequestDefault", "change_request")).to be false
        expect(data.value("InputRequirement_ChangeRequestDefault", "change_request")).to eq '-'
      end
    end

    context 'specified in a spec directive' do
      before(:all) do
        @test = Test.new("change_request_spec")
        @test.run
      end

      it 'shall cause dox_trace to abort with exit code != 0 and print an error message', doc_refs: ['DoxTrace_Syntax_ChangeRequest'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'index.rst:7:Error in "spec" directive'
        expect(@test.test_stderr).to include 'unknown option: "change_request"'
      end
    end

    context 'specified in a unit directive' do
      before(:all) do
        @test = Test.new("change_request_unit")
        @test.run
      end

      it 'shall cause dox_trace to abort with exit code != 0 and print an error message', doc_refs: ['DoxTrace_Syntax_ChangeRequest'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'index.rst:7:Error in "unit" directive'
        expect(@test.test_stderr).to include 'unknown option: "change_request"'
      end
    end

    context 'specified in an interface directive' do
      before(:all) do
        @test = Test.new("change_request_interface")
        @test.run
      end

      it 'shall cause dox_trace to abort with exit code != 0 and print an error message', doc_refs: ['DoxTrace_Syntax_ChangeRequest'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'index.rst:7:Error in "interface" directive'
        expect(@test.test_stderr).to include 'unknown option: "change_request"'
      end
    end

    context 'specified in an information directive' do
      before(:all) do
        @test = Test.new("change_request_information")
        @test.run
      end

      it 'shall cause dox_trace to abort with exit code != 0 and print an error message', doc_refs: ['DoxTrace_Syntax_ChangeRequest'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'index.rst:7:Error in "information" directive'
        expect(@test.test_stderr).to include 'unknown option: "change_request"'
      end
    end

    context 'specified in an mod directive' do
      before(:all) do
        @test = Test.new("change_request_mod")
        @test.run
      end

      it 'shall cause dox_trace to abort with exit code != 0 and print an error message', doc_refs: ['DoxTrace_Syntax_ChangeRequest'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'index.rst:7:Error in "mod" directive'
        expect(@test.test_stderr).to include 'unknown option: "change_request"'
      end
    end

    context 'specified in an srs directive' do
      before(:all) do
        @test = Test.new("change_request_srs")
        @test.run
      end

      it 'shall cause dox_trace to abort with exit code != 0 and print an error message', doc_refs: ['DoxTrace_Syntax_ChangeRequest'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'index.rst:7:Error in "srs" directive'
        expect(@test.test_stderr).to include 'unknown option: "change_request"'
      end
    end

  end
end
