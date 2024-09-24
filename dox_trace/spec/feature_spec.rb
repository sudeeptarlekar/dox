require_relative 'framework/helper'

module Sphinx
  describe "The attribute feature" do
    context 'with correct syntax' do
      before(:all) do
        @test = Test.new("feature")
        @test.run
      end

      it 'shall be loaded and displayed correctly without any error', doc_refs: ['DoxTrace_Syntax_Feature', 'DoxTrace_HTML_Feature'] do
        expect(@test.exit_code).to be == 0
        data = HtmlData.new("feature", "index.html")

        expect(data.exist?("SRS_Requirement_FeatureSet", "feature")).to be false
        expect(data.value("InputRequirement_FeatureSet", "feature")).to eq 'Dd'

        expect(data.exist?("SRS_Requirement_FeatureDefault", "feature")).to be false
        expect(data.value("InputRequirement_FeatureDefault", "feature")).to eq '-'
      end
    end

    context 'specified in a spec directive' do
      before(:all) do
        @test = Test.new("feature_spec")
        @test.run
      end

      it 'shall cause dox_trace to abort with exit code != 0 and print an error message', doc_refs: ['DoxTrace_Syntax_Feature'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'index.rst:7:Error in "spec" directive'
        expect(@test.test_stderr).to include 'unknown option: "feature"'
      end
    end

    context 'specified in a unit directive' do
      before(:all) do
        @test = Test.new("feature_unit")
        @test.run
      end

      it 'shall cause dox_trace to abort with exit code != 0 and print an error message', doc_refs: ['DoxTrace_Syntax_Feature'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'index.rst:7:Error in "unit" directive'
        expect(@test.test_stderr).to include 'unknown option: "feature"'
      end
    end

    context 'specified in an interface directive' do
      before(:all) do
        @test = Test.new("feature_interface")
        @test.run
      end

      it 'shall cause dox_trace to abort with exit code != 0 and print an error message', doc_refs: ['DoxTrace_Syntax_Feature'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'index.rst:7:Error in "interface" directive'
        expect(@test.test_stderr).to include 'unknown option: "feature"'
      end
    end

    context 'specified in an information directive' do
      before(:all) do
        @test = Test.new("feature_information")
        @test.run
      end

      it 'shall cause dox_trace to abort with exit code != 0 and print an error message', doc_refs: ['DoxTrace_Syntax_Feature'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'index.rst:7:Error in "information" directive'
        expect(@test.test_stderr).to include 'unknown option: "feature"'
      end
    end

    context 'specified in an mod directive' do
      before(:all) do
        @test = Test.new("feature_mod")
        @test.run
      end

      it 'shall cause dox_trace to abort with exit code != 0 and print an error message', doc_refs: ['DoxTrace_Syntax_Feature'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'index.rst:7:Error in "mod" directive'
        expect(@test.test_stderr).to include 'unknown option: "feature"'
      end
    end

    context 'specified in an srs directive' do
      before(:all) do
        @test = Test.new("feature_srs")
        @test.run
      end

      it 'shall cause dox_trace to abort with exit code != 0 and print an error message', doc_refs: ['DoxTrace_Syntax_Feature'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'index.rst:7:Error in "srs" directive'
        expect(@test.test_stderr).to include 'unknown option: "feature"'
      end
    end

  end
end
