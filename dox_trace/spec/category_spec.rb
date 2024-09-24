require_relative 'framework/helper'

module Sphinx
  describe "The attribute category" do
    context 'with correct syntax' do
      before(:all) do
        @test = Test.new("category")
        @test.run
      end

      it 'shall be loaded and displayed correctly without any error', doc_refs: ['DoxTrace_Syntax_Category'] do
        expect(@test.exit_code).to be == 0
        data = HtmlData.new("category", "index.html")

        # comment is only visible for input requirements, not for software requirements

        expect(data.exist?("SRS_Information_CategorySet", "comment")).to be false
        expect(data.exist?("SRS_Requirement_CategorySet", "comment")).to be false
        expect(data.exist?("InputInformation_CategorySet", "comment")).to be true
        expect(data.exist?("InputRequirement_CategorySet", "comment")).to be true

        expect(data.exist?("DefaultInformation_CategoryDefault", "comment")).to be true
        expect(data.exist?("DefaultRequirement_CategoryDefault", "comment")).to be true
      end

      it 'shall not be exported', doc_refs: ['DoxTrace_Export_Category'] do
        dim = File.read("#{$test_input_dir}/category/export_root/swa/index.dim")
        expect(dim).not_to match(/category/)
      end
    end

    context 'specified in a spec directive' do
      before(:all) do
        @test = Test.new("category_spec")
        @test.run
      end

      it 'shall cause dox_trace to abort with exit code != 0 and print an error message', doc_refs: ['DoxTrace_Syntax_Category'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'index.rst:7:Error in "spec" directive'
        expect(@test.test_stderr).to include 'unknown option: "category"'
      end
    end

    context 'specified in a unit directive' do
      before(:all) do
        @test = Test.new("category_unit")
        @test.run
      end

      it 'shall cause dox_trace to abort with exit code != 0 and print an error message', doc_refs: ['DoxTrace_Syntax_Category'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'index.rst:7:Error in "unit" directive'
        expect(@test.test_stderr).to include 'unknown option: "category"'
      end
    end

    context 'specified in an interface directive' do
      before(:all) do
        @test = Test.new("category_interface")
        @test.run
      end

      it 'shall cause dox_trace to abort with exit code != 0 and print an error message', doc_refs: ['DoxTrace_Syntax_Category'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'index.rst:7:Error in "interface" directive'
        expect(@test.test_stderr).to include 'unknown option: "category"'
      end
    end

    context 'specified in an mod directive' do
      before(:all) do
        @test = Test.new("category_mod")
        @test.run
      end

      it 'shall cause dox_trace to abort with exit code != 0 and print an error message', doc_refs: ['DoxTrace_Syntax_Category'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'index.rst:7:Error in "mod" directive'
        expect(@test.test_stderr).to include 'unknown option: "category"'
      end
    end

    context 'specified in an srs directive' do
      before(:all) do
        @test = Test.new("category_srs")
        @test.run
      end

      it 'shall cause dox_trace to abort with exit code != 0 and print an error message', doc_refs: ['DoxTrace_Syntax_Category'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'index.rst:7:Error in "srs" directive'
        expect(@test.test_stderr).to include 'unknown option: "category"'
      end
    end

  end
end
